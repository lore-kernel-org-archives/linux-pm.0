From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 0/6] General Key Derivation Function Support
Date: Fri, 8 Feb 2019 15:45:58 +0800
Message-ID: <20190208074558.j3k6gw66q4e2y2lv@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com>
 <5418064.ltLFQScYi2@tauon.chronox.de>
 <20190130100854.iey2mbmz6777pn2n@gondor.apana.org.au>
 <12103603.N4N57GesWC@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12103603.N4N57GesWC@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 30, 2019 at 03:39:10PM +0100, Stephan Mueller wrote:
> Am Mittwoch, 30. Januar 2019, 11:08:54 CET schrieb Herbert Xu:
> 
> Hi Herbert,
> 
> > I'm still not convinced why this needs to go into the crypto API
> > instead of being hosted in a helper which should achieve pretty
> > much the same result.
> 
> How do you propose to handle the FIPS 140-2 related requirements of enforcing 
> the integrity test result and the known-answer self tests?

We could easily add self-tests for the helper.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
