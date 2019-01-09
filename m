From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 9 Jan 2019 00:21:04 -0800
Message-ID: <20190109082103.GA8586@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com>
 <309406107.k3W2fMQUza@tauon.chronox.de>
 <1547017108.2789.24.camel@HansenPartnership.com>
 <1894062.aDvIuj92vB@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1894062.aDvIuj92vB@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2019 at 08:05:21AM +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 07:58:28 CET schrieb James Bottomley:
> 
> Hi James,
> 
> > On Wed, 2019-01-09 at 07:45 +0100, Stephan Mueller wrote:
> > > Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James Bottomley:
> > > 
> > > Hi James,
> > > 
> > > > Actually, it would be enormously helpful if we could reuse these
> > > > pieces for the TPM as well.
> > > 
> > > Could you please help me understand whether the KDFs in TPM are
> > > directly usable as a standalone cipher primitive or does it go
> > > together with additional  key generation operations?
> > 
> > They're used as generators ... which means they deterministically
> > produce keys from what the TPM calls seeds so we can get crypto agility
> > of TPM 2.0 ... well KDFa does.  KDFe is simply what NIST recommends you
> > do when using EC for a shared key agreement ... and really we shouldn't
> > be using ECDH in the kernel without it.
> > 
> 
> Thanks for clarifying. That would mean that indeed we would have hardware-
> provided KDF implementations that may be usable with the kernel crypto API.
> 
> [...]
> > 
> > > Would it be appropriate, to implement a type cast to a structure from
> > > the u8 pointer?
> > > 
> > > E.g. for the aforementioned label/context data, we could define
> > > something like
> > > 
> > > struct crypto_kdf_ctr {
> > > 
> > > 	char *label;
> > > 	size_t label_len;
> > > 	u8 *contextU;
> > > 	size_t contextU_len;
> > > 	u8 *contextV;
> > > 	size_t contextV_len;
> > > 
> > > };
> > > 
> > > And the implementation of the generate function for CTR KDF would
> > > 
> > > then have a  type cast along the following lines:
> > > 	if (slen != sizeof(struct crypto_kdf_ctr))
> > > 	
> > > 		return -EINVAL;
> > > 	
> > > 	const struct crypto_kdf_ctr *kdf_ctr_input = (struct
> > > 
> > > crypto_kdf_ctr *)src;
> > > 
> > > 
> > > For different KDFs, different structs would be needed.
> > 
> > Actually, we probably just need the input key (or secret material), the
> > concatenation and the number of output bits.
> 
> Thanks for confirming. Though, when it comes to HKDF (not that I see it being 
> needed or required in the kernel), there is a need to split up the src pointer 
> since the mentioned input is used in different ways.
> 
> In order to try to get the implementation and thus the interface right, I 
> would suggest to at least have a consensus on how to handle such situations.
> 
> Thus, would the proposal be acceptable for such KDFs that may need to have 
> different components communicated as input to the KDF?
> 

FWIW, it's been very slow going since I've been working on other projects and I
also need to be very sure to get the API changes right, but I still plan to
change the KDF in fscrypt (a.k.a. ext4/f2fs/ubifs encryption) to HKDF-SHA512 as
part of a larger set of improvements to how fscrypt encryption keys are managed.
I sent the last patchset a year ago
(https://marc.info/?l=linux-fsdevel&m=150879493206257) but I'm working to revive
it.  In the work-in-progress version in my git tree, this is the commit that
adds a HKDF implementation as fs/crypto/hkdf.c:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=e8a78767131c9717ee838f0c4e307948d65a4427
It basically just wraps a crypto_shash for "hmac(sha512)".

I'd be fine with using a common implementation instead, provided that it gives
the same functionality, including supporting user-specified salt and
application-specific info strings, and isn't slower or more complex to use.

(This comment is solely on the tangential discussion about KDF implementations;
I've not looked at the hibernation image encryption stuff yet.)

- Eric
