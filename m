From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 12:11:33 +0200
Message-ID: <20190327101133.GQ22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327095337.GP22899@mtr-leonro.mtl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 11:53:37AM +0200, Leon Romanovsky wrote:
> On Wed, Mar 27, 2019 at 02:49:02AM -0700, Joe Perches wrote:
> > On Wed, 2019-03-27 at 11:38 +0200, Leon Romanovsky wrote:
> > > On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> > > > On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > option) than available CPUs will have prints like this:
> > > > []
> > > > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > > > []
> > > > > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> > > > >  	if (num_processors >= nr_cpu_ids) {
> > > > >  		int thiscpu = max + disabled_cpus;
> > > > >
> > > > > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > > > > -			   "reached. Processor %d/0x%x ignored.\n",
> > > > > -			   max, thiscpu, apicid);
> > > > > +		pr_debug(
> > > > > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > > > +			max, thiscpu, apicid);
> > > >
> > > > 2 lines please
> > > >
> > > > 		pr_debug("APIC: etc...",
> > > > 			 max, thiscpu, ...);
> > >
> > > It was two lines before, but I changed for two reasons:
> > >  * It helped me to grep the source code to find the origin of dmesg warning.
> > >  * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?
> >
> > Yes, use
> >
> > 	pr_debug("APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > 		 max, thiscpu, apicid);
>
> Ahh, I see, I got such change from clang formatter.
>
> >
> > or better
> >
> > 	printk(KERN_DEBUG "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > 	       max, thiscpu, apicid);
> >
> > > > And this would probably be better as
> > > >
> > > > 		printk(KERN_DEBUG "APIC: etc...",
> > > > 		 ...)
> > > >
> > > > to avoid the need to compile with DEBUG or enable
> > > > with CONFIG_DYNAMIC_DEBUG
> > >
> > > You don't need anything like this, just provide dyndbg parameters
> > > through kernel command line.
> >
> > That assumes CONFIG_DYNAMIC_DEBUG is always enabled,
> > and it is not enabled in many .config files.
>
> No problem.

ok, I tested your variant and it still prints a t least on my systems,
so it won't solve my problem. I'll keep this patch as is.

Thanks for the review.

>
> Thanks
>
> >
> >



--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm0xVAAoJEORje4g2clinwAkP/AqMkyPfgg3jJorgJEFjlDgG
yAU3UZD1CbLSjkGi1/QN3KxJDUsowtHNGL8S+a5Yx79AxGgBfj30uNahrr0SiXPq
8pk2ScTQZY9Bbp4UATALpnpml/OH7pePpKjKMY4c78Web/W6jPOesmpyxQ2CRGcs
f8SgmcFHZM80Rdn2oc3pAH1Gtmo3RK4BmUv5osi4QLogfJ/nKW2ztZPSqVuRlZxq
HIFzoTuZZd/grzHCVFicSjh1ahXF94wOlLnEBeeEtye0Ua5DsuurMV9tEEsuXW1S
3bcBbTAsN/UuBYehjk2oKS4qy2fhqajBHcbf7m5pxuT+dJXozY0+noRgh938OYgR
FP/9fHpjZTQWe671tngjBr4XihSyPBXKBgDallb6ztFJyJS3yRIDRAGeMVNlq5Jr
IbaU+m7SeIq0D8R/WTnnKLYTyii5uHvWQPqohimDRdExuLt5D3Cr1jzyVGc7wED2
tdfiEjzZyv1Nwy/PMWiJFXr+bI8+IvoWB7DHetSt9JGtDWqvcqs0/iCnfyaaw5xd
23AKveeVmJLbLdBZu7a0dSoZ0Q8hxeHctMVB9uS9eY5NGhH5xtlgIoGeD0wTT+zY
COVEOyP1eAHrHsvomdmWTwdPexuY+yBzVMxRvNxQ7YZH1Dx62cHp8eWMnZMlTd58
yzXVZG5Pkm1rDiwSSmuG
=cPX/
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
