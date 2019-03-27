From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 11:38:44 +0200
Message-ID: <20190327093844.GO22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > option) than available CPUs will have prints like this:
> []
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> []
> > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> >  	if (num_processors >= nr_cpu_ids) {
> >  		int thiscpu = max + disabled_cpus;
> >
> > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > -			   "reached. Processor %d/0x%x ignored.\n",
> > -			   max, thiscpu, apicid);
> > +		pr_debug(
> > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > +			max, thiscpu, apicid);
>
> 2 lines please
>
> 		pr_debug("APIC: etc...",
> 			 max, thiscpu, ...);

It was two lines before, but I changed for two reasons:
 * It helped me to grep the source code to find the origin of dmesg warning.
 * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?

>
> And this would probably be better as
>
> 		printk(KERN_DEBUG "APIC: etc...",
> 		 ...)
>
> to avoid the need to compile with DEBUG or enable
> with CONFIG_DYNAMIC_DEBUG

You don't need anything like this, just provide dyndbg parameters
through kernel command line.

Thanks

>
>
>

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm0SkAAoJEORje4g2clinN7QP/jZp/ADzvPaJ9EySTUBmx+9Z
AzQOi6t2y8WQfWIhYUbsXrDKRo9cE2EekNCpZyDj1XVFORoa1lPDAWsMZgY1Isgk
L6MXAt9NmdWXENzmADPdVmgnoEC93EM0+ZLiH9wjLMelAHe3R3ZJd7+ki/XG9h5O
4K1IVlZwZEx7jctvXKXl1AE5Kag2tntF2V1XFjxPDjoLpdKrUnIC2ceDzkSY+RQU
ivffCAaoXA92TysNzyXK+1kjNJkUBMro5Bn1jq5qdFBhc71PuCd3MfFNOm40aTRK
MeG4ncpSTOFFk5JnrYHnYJf9dQOVrN0KvvmT3Jxdy4tnfiJpn6aBd4jSpfcagtM7
N//+Bc1Cmyy41wCB2gaCKsU0C2/uF8Ca5AXN2jfCp8bel6cACHwSabTr7NgR6sRs
UL4K9b5WXycnH3fDMINDMlz6bcr4lbQ9ymlCNA5BP44DkQInHgdCgcjXcd31nQid
GbcDzrXoOf50ycNCEgVw6jcx1rHkcExcGMFQ3PkRJ6a1cYtgtq4MtTVOgsQrK64e
rrhZKhoDraLFQqshg6rBDB9n+P7kEZ00U+dKjsdXCWLjqbZBlv6npbDplbTIGvRJ
a7itpqOBI0/hmdhijj/9kBbuKiRJ98oV7j1ubu3HzKegObLFUQA5i2qWNu+9snmJ
bES/RlwjkYx6zd+Vuz29
=bJ+i
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
