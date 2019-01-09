From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 09 Jan 2019 13:43:40 -0800
Message-ID: <1547070220.2758.4.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
         <1547016579.2789.17.camel@HansenPartnership.com>
         <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
         <1547063189.2879.47.camel@HansenPartnership.com>
         <CALCETrWKUTKp1tO00fPcbtm5vu2b4CHJQ6XcmkrWJY9P1h+mzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWKUTKp1tO00fPcbtm5vu2b4CHJQ6XcmkrWJY9P1h+mzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Stephan Mueller <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-01-09 at 12:12 -0800, Andy Lutomirski wrote:
> On Wed, Jan 9, 2019 at 11:46 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:

[...]
> > > I’m not sure I follow. Here are the two properties I’d like to
> > > see:
> > > 
> > > 1. If you have an encrypted hibernation image, the only thing you
> > > should be able to do with it is to restore it. So only an actual
> > > Linux kernel in hibernation restore mode ought to be able to
> > > restore it.  We get this if the image can only be read with
> > > appropriate PCRs and then only by the kernel.  This way, you
> > > can’t just read out secrets from the image if you steal a laptop
> > > — you have to actually boot the thing.
> > 
> > Right, this we can do and if you use a TPM sealed encryption key,
> > you can guarantee the image will only restore on the same physical
> > system. You don't need PCRs for this, just the TPM and the locality
> > enforcement.
> > 
> > Note if someone has your laptop and the ability to boot their own
> > kernels, they could always corrupt the kernel into decrypting the
> > image or giving you the unsealed key, but there's no real way of
> > preventing that even with PCR sealing or lockdown, so the basis for
> > the threat model is very much my laptop in my possession running my
> > kernel.
> 
> I'm not entirely sure I agree.  With a TPM-aware bootloader, it
> really ought to be possible to seal to PCRs such that a corrupted
> kernel can't restore the image.  Obviously a *compromised* but
> otherwise valid kernel will be able to restore the image.

It is possible to seal the key so that only the same booted kernel can
restore the image, yes.  One of the measurements that goes into the
boot log is the hash of the kernel and you can seal to this value ...
obviously if you upgrade your kernel RPM (or shim or grub) this value
changes and you'd lose the ability to restore the hibernated image, but
since the image is very kernel specific, that's probably OK.

> But this is all barking up the wrong tree.  If you want your laptop
> to resist physical theft such that whoever stole it can boot it but
> can't directly extract any data, you want to use dm-crypt (or, haha,
> OPAL, but I just read a paper about some people who evaluated a bunch
> of drives and had a very hard time finding one that actually
> implemented OPAL in a usefully secure manner).  A LUKS replacement or
> wrapper that does something intelligent with the TPM would be
> great.  This kind of thing IMO does not belong in hibernation.

Right, so the simplest way of doing this is to save the image on an
encrypted partition or filesystem which must be unlocked by a password
on boot.

> IOW, I think we do get about as much as we would want if we just seal
> with a locality that only allows kernel use and ignore PCRs entirely.
> This makes it so that you need the ability to run ring 0 code to
> decrypt the image, which means that we get all the nice lockdown
> properties.

Yes, it's a useful balance of security and ease of implementation, I
think.

> > > 2. You shouldn’t be able to create an intentionally corrupt image
> > > that pwns you when you restore it unless you have already pwned
> > > the kernel.
> > 
> > So here there's a problem: the policy stated above governs key
> > *use* not key creation, so anyone can create a key that has a
> > locality restriction.  The way to guarantee that the key was
> > created by something that has access to the locality is to have a
> > parent key with a locality use policy (key creation requires parent
> > key use authorization).  Which means every system would have to
> > create a persistent parent key for the kernel to use (the kernel
> > could do this and it could be made NV resident for persistence, so
> > it's not impossible, just complicated).
> 
> Why does anything here need to be persistent?  The kernel could
> create a locality-restricted key on the fly, use it to sign and/or
> seal the hibernation image, and write the wrapped key blob into the
> hibernation image.

Yes, but so could I as a malicious user with a desire to create a bad
hibernation image.  I could do it entirely in userspace.  I need access
to the TPM to seal the key, but I'd get that:  All you see in-kernel is
a single policy sha256 sum and you can't reverse that back to the
actual policy, so the kernel has no idea what policy is being sealed
and so can't police the policy.

In order to get the security that only the kernel created the
hibernation key, you need to have a key parent with a policy that only
allows in-kernel locality use so you know the child key was created by
the kernel and nothing else.

>  > I suppose that a good summary of my opinion is that there is no
> point
> > > to kernel support for encrypted hibernation images until lockdown
> > > is upstream.
> > 
> > I really don't think lockdown helps.  If we implement locality
> > isolation for the kernels use of keys, a properly functioning
> > kernel isn't going to be tricked into releasing one of its keys to
> > userspace. A buggy kernel might be exploited to cause it to give
> > one up but that would happen irrespective of lockdown and, of
> > course, all bets are off if the attacker can boot their own kernel.
> > 
> 
> I'm not saying that lockdown helps.  I'm saying that encrypting the
> hibernation image in the kernel may be pointless until the kernel
> supports lockdown.  If we don't support lockdown, then user code can
> encrypt the hibernation image all by itself.  The code will be easier
> to understand, more flexible, and won't require a kernel upgrade :)

Well, protection of at-rest images is one reason, but I accept that
simply writing them to dm-crypt storage is a better way of doing this
and solves the key problem nicely.

James

> Honestly, no one should be using resume= anyway.  Any distro with
> hibernation support worth its salt should support having the
> hibernation image on a dm-crypt volume, in which case it *must*
> support userspace-driven resume.  Of course, my laptop that's been
> upgraded through many Fedora revisions doesn't survive a
> hibernate/resume cycle, but that's not the kernel's fault.
> 
> --Andy
> 
> P.S. One thing I do want to try is encrypted *swap*.  The keying for
> that is trivial -- the kernel can just make a key, store it in
> ordinary kernel memory, and use it to encrypt and decrypt swap pages
> as needed.  Getting replay protection or authentication may be tricky
> due to the need for metadata, but plain old AES-XTS or
> HPolyChaChaNotSpeckAnymore would be entirely straightforward and
> would
> get 90% of the benefit.  Sure, swap could live on dm-crypt too, but
> that's an administration mess, and offering a strong and cheap
> alternative to mlock() for crypto programs to protect their secrets
> would be fantastic and encrypted swap plus some API to verify that
> anonymous memory is, in fact, backed by encrypted swap would do the
> job.
> 
