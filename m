From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 0/6] General Key Derivation Function Support
Date: Tue, 19 Feb 2019 13:44:58 +0800
Message-ID: <20190219054458.ldwl26npnyg7ulic@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com>
 <1798550.XZem68xxzE@tauon.chronox.de>
 <20190208080547.224fudg2m22d3a6d@gondor.apana.org.au>
 <2047284.dgeq8KlW64@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2047284.dgeq8KlW64@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 08, 2019 at 09:17:50AM +0100, Stephan Mueller wrote:
> > 
> > > Also, shall we add the signature verification enforcemnt to the helper as
> > > well?
> > 
> > What do you mean by that?
> 
> We need to invoke the function crypto_check_module_sig when the module is 
> loaded. Do you have any concerns invoking it from the module init function?

Which module's signature are you going to check? If it's the
underlying crypto API modules then wouldn't they have been
checked already when they were registered?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
