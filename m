From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Fri, 11 Jan 2019 18:04:13 +0200
Message-ID: <20190111160413.GB12093@linux.intel.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
 <1547016579.2789.17.camel@HansenPartnership.com>
 <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Stephan Mueller <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2019 at 10:34:42AM -0800, Andy Lutomirski wrote:
> I suppose I should go read the 2.0 spec. I’ve read the 1.2 spec, but I
> always assumed that 2.0 was essentially a superset of 1.2
> functionality.

They are essentially different protocols. No real compatibility.


> Can the kernel filter TPM 2.0 operations?  If so, then a signature
> that the kernel would have prevented user code from generating is de
> facto an attestation that the kernel generated it (or that the kernel
> was compromised, which is sort of equivalent).

You shoud look into TPM resource manager that I implemented with great
work from James on session swapping and see how far it scales what you
have in mind. It is currently exposed only to the user space but could
be easily made an in-kernel API.

Side-topic: right now the TPM driver can be compiled as a module when
its APIs are not used by the kernel (namely IMA and trusted keys) with
some Kconfig magic. Since it looks like that there will be even more
customers, I think it would make sense to make the TPM driver core as
part of the core kernel (device drivers for different types of chips
could still be modules). I've proposed this before maybe two times, but
it has always been rejected.

/Jarkko
