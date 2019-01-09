From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 09 Jan 2019 19:18:13 +0100
Message-ID: <2049180.FbvvROCS3Z@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <2344329.gmPllosFfp@tauon.chronox.de> <20190109173454.GB249140@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109173454.GB249140@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 18:34:55 CET schrieb Eric Biggers:

Hi Eric,

> That would not meet my performance requirements as I want to precompute
> HKDF-Extract, and then do HKDF-Expand many times.  Also the HKDF-Expand part
> should be thread-safe and not require allocating memory, especially not a
> whole crypto_shash tfm every time.
> 
> So presumably with crypto_rng, crypto_rng_reset() would need to take the
> input keyring material and salt and do HKDF-Extract (like my
> fscrypt_init_hkdf()), and crypto_rng_generate() would need to take the
> application-specific info string and do HKDF-Expand (like my
> fscrypt_hkdf_expand()).

Great, that was the idea I had in mind as well. Maybe the example was not 
right to convey that. Let me work on that.
> 
> It is ugly though.  Please also consider just having simple crypto_hkdf_*()
> helper functions which wrap a HMAC tfm along the lines of my patch, rather
> than shoehorning it into the crypto_rng API.
> 
> - Eric



Ciao
Stephan
