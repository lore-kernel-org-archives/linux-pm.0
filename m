From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Fri, 18 Jan 2019 12:59:06 -0800
Message-ID: <1547845146.2794.69.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
         <20190111140226.GA6448@linux.intel.com>
         <1547220538.2793.6.camel@HansenPartnership.com>
         <20190118143348.GB4080@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118143348.GB4080@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Stephan Mueller <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-01-18 at 16:33 +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 11, 2019 at 07:28:58AM -0800, James Bottomley wrote:
> > On Fri, 2019-01-11 at 16:02 +0200, Jarkko Sakkinen wrote:
> > > On Tue, Jan 08, 2019 at 05:43:53PM -0800, Andy Lutomirski wrote:
> > > > (Also, do we have a sensible story of how the TPM interacts
> > > > with hibernation at all?  Presumably we should at least try to
> > > > replay the PCR operations that have occurred so that we can
> > > > massage the PCRs into the same state post-hibernation.  Also,
> > > > do we have any way for the kernel to sign something with the
> > > > TPM along with an attestation that the signature was requested
> > > > *by the kernel*?  Something like a sub-hierarchy of keys that
> > > > the kernel explicitly prevents userspace from accessing?)
> > > 
> > > Kernel can keep it is own key hierarchy in memory as TPM2 chips
> > > allow to offload data in encrypted form and load it to TPM when
> > > it needs to use it.
> > > 
> > > The in-kernel resource manager that I initiated couple years ago
> > > provides this type of functionality.
> > 
> > Actually, the resource manager only keeps volatile objects
> > separated when in use not when offloaded.  The problem here is that
> > the object needs to be persisted across reboots, so either it gets
> > written to the NV area, bypassing the resource manager and making
> > it globally visible or it has to get stored in TPM form in the
> > hibernation image, meaning anyone with access to the TPM who can
> > read the image can extract and load it. Further: anyone with access
> > to the TPM can create a bogus sealed key and encrypt a malicious
> > hibernation image with it.  So there are two additional problems
> > 
> >    1. Given that the attacker may have access to the binary form of
> > the
> >       key, can we make sure only the kernel can get it released?
> >    2. How do we prevent an attacker with access to the TPM from
> > creating a
> >       bogus sealed key?
> > 
> > This is why I was thinking localities.
> 
> Why you would want to go for localities and not seal to PCRs?

Because the requested functionality was a key that would be accessible
to the kernel and not to user space and also guaranteed created by the
kernel.  The only discriminator we have to enforce that is the locality
(assuming we reserve a locality as accessible to the kernel but
inaccessible to userspace).  PCRs alone can't restrict where the key is
accessed or created from.

James
