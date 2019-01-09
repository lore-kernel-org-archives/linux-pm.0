From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 9 Jan 2019 09:34:55 -0800
Message-ID: <20190109173454.GB249140@gmail.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <1894062.aDvIuj92vB@tauon.chronox.de>
 <20190109082103.GA8586@sol.localdomain>
 <2344329.gmPllosFfp@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2344329.gmPllosFfp@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2019 at 11:17:45AM +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 09:21:04 CET schrieb Eric Biggers:
> 
> Hi Eric,
> > 
> > FWIW, it's been very slow going since I've been working on other projects
> > and I also need to be very sure to get the API changes right, but I still
> > plan to change the KDF in fscrypt (a.k.a. ext4/f2fs/ubifs encryption) to
> > HKDF-SHA512 as part of a larger set of improvements to how fscrypt
> > encryption keys are managed. I sent the last patchset a year ago
> > (https://marc.info/?l=linux-fsdevel&m=150879493206257) but I'm working to
> > revive it.  In the work-in-progress version in my git tree, this is the
> > commit that adds a HKDF implementation as fs/crypto/hkdf.c:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=e8a78767131c9717ee838f0c4e307948d65a4427
> > It basically just wraps a crypto_shash for "hmac(sha512)".
> > 
> > I'd be fine with using a common implementation instead, provided that it
> > gives the same functionality, including supporting user-specified salt and
> > application-specific info strings, and isn't slower or more complex to use.
> > 
> > (This comment is solely on the tangential discussion about KDF
> > implementations; I've not looked at the hibernation image encryption stuff
> > yet.)
> 
> Thanks for the clarification. I have started a generic HKDF implementation for 
> the kernel crypto API which lead to the questions above. I would then also try 
> to provide a HKDF proposal.
> 
> To use the (H)KDF, I currently envision 2 calls apart from alloc/free. The 
> following code would serve as an example.
> 
>  * Example without proper error handling:
>  *      char *keying_material = "\x00\x11\x22\x33\x44\x55\x66\x77";
>  *      char *label_context = "\xde\xad\xbe\xef\x00\xde\xad\xbe\xef";
>  *      kdf = crypto_alloc_rng(name, 0, 0);
>  *      crypto_rng_reset(kdf, keying_material, 8);
>  *      crypto_rng_generate(kdf, label_context, 9, outbuf, outbuflen);
> 
> That hopefully should be simple enough.
> 
> For HKDF, as mentioned, I would envision to use a struct instead of a char * 
> for the label_context to communicate IKM, Salt, and the label/info 
> information.
> 
> Ciao
> Stephan
> 

That would not meet my performance requirements as I want to precompute
HKDF-Extract, and then do HKDF-Expand many times.  Also the HKDF-Expand part
should be thread-safe and not require allocating memory, especially not a whole
crypto_shash tfm every time.

So presumably with crypto_rng, crypto_rng_reset() would need to take the input
keyring material and salt and do HKDF-Extract (like my fscrypt_init_hkdf()), and
crypto_rng_generate() would need to take the application-specific info string
and do HKDF-Expand (like my fscrypt_hkdf_expand()).

It is ugly though.  Please also consider just having simple crypto_hkdf_*()
helper functions which wrap a HMAC tfm along the lines of my patch, rather than
shoehorning it into the crypto_rng API.

- Eric
