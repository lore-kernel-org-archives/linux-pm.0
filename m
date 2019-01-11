From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Fri, 11 Jan 2019 17:53:18 +0200
Message-ID: <20190111154146.GA12093@linux.intel.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
 <1547016579.2789.17.camel@HansenPartnership.com>
 <20190109181155.GI9503@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109181155.GI9503@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Andy Lutomirski <luto@kernel.org>, Stephan Mueller <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 02:11:55AM +0800, joeyli wrote:
> > Well, I think here, if we were actually trying to solve the problem of
> > proving the hibernated image were the same one we would need to prove
> > some log of the kernel operation came to a particular value *after* the
> > hibernated image were restored ... it's not really possible to
> > condition key release which must occur before the restore on that
> > outcome, so it strikes me we need more than a simple release bound to
> > PCR values.
> >
> 
> hm... I am studying your information. But I have a question...
> 
> If PCR is not capped and the root be compromised, is it possible that a
> sealed bundle also be compromised? 
> 
> Is it possible that kernel can produce a sealed key with PCR by TPM when
> booting? Then kernel caps a PCR by a constant value before the root is
> available for userland. Then the sealed key can be exposed to userland
> or be attached on hibernate image. Even the root be compromised, the TPM
> trusted key is still secure.

I think this even might be reasonable. Especially when we land James'
encrypted sessions patches at some point.

/Jarkko
