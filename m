From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 0/6] General Key Derivation Function Support
Date: Wed, 30 Jan 2019 18:08:54 +0800
Message-ID: <20190130100854.iey2mbmz6777pn2n@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com>
 <9733066.Vrs4h5eWcW@positron.chronox.de>
 <2082192.jPI8ve1O8G@positron.chronox.de>
 <5418064.ltLFQScYi2@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5418064.ltLFQScYi2@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 11:07:28AM +0100, Stephan Mueller wrote:
> Am Mittwoch, 16. Januar 2019, 12:06:54 CET schrieb Stephan Müller:
> 
> Hi Herbert,
> 
> > Changes v2:
> > * Incorporation of all comments from Eric Biggers
> > 
> > Stephan Mueller (6):
> >   crypto: add template handling for RNGs
> >   crypto: kdf - SP800-108 Key Derivation Function
> >   crypto: kdf - add known answer tests
> >   crypto: hkdf - HMAC-based Extract-and-Expand KDF
> >   crypto: hkdf - add known answer tests
> >   crypto: tcrypt - add KDF test invocation
> > 
> >  crypto/Kconfig                |  13 +
> >  crypto/Makefile               |   2 +
> >  crypto/hkdf.c                 | 272 +++++++++++++++++++
> >  crypto/kdf_sp800108.c         | 491 ++++++++++++++++++++++++++++++++++
> >  crypto/rng.c                  |  44 +++
> >  crypto/tcrypt.c               |   8 +
> >  crypto/testmgr.c              | 245 +++++++++++++++++
> >  crypto/testmgr.h              | 198 ++++++++++++++
> >  include/crypto/internal/rng.h |  26 ++
> >  9 files changed, 1299 insertions(+)
> >  create mode 100644 crypto/hkdf.c
> >  create mode 100644 crypto/kdf_sp800108.c
> 
> Do you happen to have any comments on this patch set?

I'm still not convinced why this needs to go into the crypto API
instead of being hosted in a helper which should achieve pretty
much the same result.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
