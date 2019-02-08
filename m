From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v2 0/6] General Key Derivation Function Support
Date: Fri, 08 Feb 2019 09:17:50 +0100
Message-ID: <2047284.dgeq8KlW64@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <1798550.XZem68xxzE@tauon.chronox.de> <20190208080547.224fudg2m22d3a6d@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208080547.224fudg2m22d3a6d@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 8. Februar 2019, 09:05:47 CET schrieb Herbert Xu:

Hi Herbert,
> 
> > Also, shall we add the signature verification enforcemnt to the helper as
> > well?
> 
> What do you mean by that?

We need to invoke the function crypto_check_module_sig when the module is 
loaded. Do you have any concerns invoking it from the module init function?

Ciao
Stephan
