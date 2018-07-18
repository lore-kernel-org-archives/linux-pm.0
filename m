From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/3][RFC] PM / Hibernate: Encrypt the snapshot pages
 before submitted to the block device
Date: Wed, 18 Jul 2018 23:48:19 +0800
Message-ID: <20180718154819.GH18419@linux-l9pv.suse>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
 <20180628130641.GG3628@linux-l9pv.suse>
 <20180628135017.GA6561@sandybridge-desktop>
 <20180628142856.GH3628@linux-l9pv.suse>
 <20180628145207.GA10891@sandybridge-desktop>
 <20180629125943.GK3628@linux-l9pv.suse>
 <20180706152856.GB9631@sandybridge-desktop>
 <20180712101037.GI7985@linux-l9pv.suse>
 <20180713073425.GA29266@sandybridge-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713073425.GA29266@sandybridge-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Gu, Kookoo" <kookoo.gu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 13, 2018 at 03:34:25PM +0800, Yu Chen wrote:
> Hi,
> On Thu, Jul 12, 2018 at 06:10:37PM +0800, joeyli wrote:
> > Hi Yu Chen, 
> > 
> > Sorry for my delay...
> > 
> > On Fri, Jul 06, 2018 at 11:28:56PM +0800, Yu Chen wrote:
[...snip]
> > > > Why the cryption code must be indepent of snapshot code?
> > > >
> > > Modules can be easier to be maintained and customized/improved in the future IMO..
> > 
> > hm... currently I didn't see apparent benefit on this...
> > 
> > About modularization, is it possible to separate the key handler code
> > from crypto_hibernation.c? Otherwise the snapshot signature needs
> > to depend on encrypt function.
> > 
> I understand.
> It seems that we can reuse crypto_data() for the signature logic.
> For example, add one parameter for crypto_data(..., crypto_mode)
> the crypto_mode is a combination of ENCRYPT/DECRYPT/SIGNATURE_START/SIGNATURE_END,
> and can be controled by sysfs. If SIGNATURE_START is enabled, the crypto_data()
> invokes crypto_shash_update() to get "hmac(sha512)" hash, and if SIGNATURE_END
> is enabled, crypto_shash_final() stores the final result in global buffer

I agree that the swsusp_prepare and hmac-hash codes can be extract to
crypto_hibernation.  

> struct hibernation_crypto.keys.digest[SNAPSHOT_DIGEST_SIZE] which can be
> passed to the restore kernel, the same as the salt. Besides,

The salt is stored in the swsusp_header and put in swap. What I want
is that the signature of snapshot should be keep in the snapshot header
as my original design in patch. The benefit is that the snapshot with
signature can be stored to any place but not just swap. The user space
can take snapshot image with signature to anywhere.

> the swsusp_prepare_hash() in your code could be moved into
> init_crypto_helper(), thus the signature key could also reuse
> the same key passed from user space or via get_efi_secret_key().
> In this way, the change in snapshot.c is minimal and the crypto
> facilities could be maintained in one file.

I agree. But as I mentioned in that mail, the key handler codes
in hibernation_crypto() should be extract to another C file to avoid
the logic is mixed with the crypto code. The benefit is that we can
add more key sources like encrypted key or EFI key in the future. 

> > > > > 2. There's no need to traverse the snapshot image twice, if the
> > > > >    image is large(there's requirement on servers now) we can
> > > > >    simplyly do the encryption before the disk IO, and this is
> > > > >    why PATCH[2/3] looks like this.
> > > > 
> > > > If the encryption solution is only for block device, then the uswsusp
> > > > interface must be locked-down when kernel is in locked mode:
> > > > 
> > > > uswsusp: Disable when the kernel is locked down
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=lockdown-20180410&id=8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
> > > > 
> > > > I still suggest to keep the solution to direct encript the snapshot
> > > > image for uswsusp because the snapshot can be encrypted by kernel
> > > > before user space get it.
> > > > 
> > > > I mean that if the uswsusp be used, then kernel direct encrypts the
> > > > snapshot image, otherwise kernel encrypts pages before block io.
> > > > 
> > > I did not quite get the point, if the kernel has been locked down,
> > > then the uswsusp is disabled, why the kernel encrypts the snapshot
> > > for uswsusp?
> > 
> > There have some functions be locked-down because there have no
> > appropriate mechanisms to check the integrity of writing data. If
> > the snapshot image can be encrypted and authentication, then the
> > uswsusp interface is avaiable for userspace. We do not need to lock
> > it down.
> Ok, I got your point. To be honest, I like your implementation to treat
> the snapshot data seperately except that it might cause small overhead
> when traversing large number of snapshot and make snapshot logic a little
> coupling with crypto logic. Let me send our v2 using the crypto-before-blockio
> for review and maybe change to your solution using the encapsulated APIs in
> crypto_hibernate.c.

Because sometimes I stick on other topics...

If you are urgent for pushing your encryption solution. Please do not
consider too much on signature check. Just complete your patches and push
to kernel mainline. I will follow your result to respin my signature work.

Thanks
Joey Lee 
