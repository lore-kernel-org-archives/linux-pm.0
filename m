From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit
 announcement
Date: Tue, 26 Mar 2019 20:31:04 +0200
Message-ID: <20190326183104.GL22899@mtr-leonro.mtl.com>
References: <20190326120213.28633-1-leon@kernel.org>
 <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
 <20190326144137.GB22899@mtr-leonro.mtl.com>
 <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
 <20190326153235.GH22899@mtr-leonro.mtl.com>
 <CAJZ5v0i2FKvKHZMttJjZR+FY_UGkku-C3=fg9FhNv-OWpu7ayA@mail.gmail.com>
 <20190326175338.GK22899@mtr-leonro.mtl.com>
 <CAJZ5v0iEfZKBGemHfc1iMK-qyo6t+h_yG-QOtmWY5ip0g21kdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iEfZKBGemHfc1iMK-qyo6t+h_yG-QOtmWY5ip0g21kdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 07:08:07PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 6:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Mar 26, 2019 at 05:30:22PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 26, 2019 at 4:32 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 26, 2019 at 04:12:27PM +0100, Rafael J. Wysocki wrote:
> > > > > On Tue, Mar 26, 2019 at 3:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> > > > > > > On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > > >
> > > > > > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > >
> > > > > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > > > > option) than available CPUs will have prints like this:
> > > > > > > >
> > > > > > > > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > > > > > > > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> > > > > > > >
> > > > > > > > Those warnings are printed for every not-enabled CPU and on the systems
> > > > > > > > with large number of such CPUs, we see a lot of those prints for default
> > > > > > > > print level.
> > > > > > > >
> > > > > > > > Simple conversion of those prints to be in debug level removes them
> > > > > > > > while leaving the option to debug system.
> > > > > > >
> > > > > > > But generally dynamic debug must be enabled in order for pr_debug()
> > > > > > > prints to be visible which is kind of cumbersome to do via the command
> > > > > > > line.
> > > > > >
> > > > > > It is doable and documented pretty well, which is uncommon :)
> > > > > > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process
> > > > >
> > > > > I know.
> > > > >
> > > > > That's what I mean by "kind of cumbersome", because you need to know
> > > > > which debug messages to enable upfront.
> > > > >
> > > > > > >
> > > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > > ---
> > > > > > > >  arch/x86/kernel/acpi/boot.c | 2 +-
> > > > > > > >  arch/x86/kernel/apic/apic.c | 6 +++---
> > > > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > > > > > index 8dcbf6890714..3ef8ab89c02d 100644
> > > > > > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > > > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > > > > > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > > > > > >
> > > > > > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > > > > > >         if (cpu < 0) {
> > > > > > > > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > > > > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > > >
> > > > > > > And this one is printed sometimes when something really goes wrong
> > > > > > > which may be really hard to debug otherwise, so there is value in the
> > > > > > > info level here.
> > > > > > >
> > > > > > > Would it be possible to avoid printing it just in some cases?
> > > > > >
> > > > > > This can do the trick:
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > > > index 3ef8ab89c02d..00212b3991e0 100644
> > > > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > > > @@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > > > >
> > > > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > > > >         if (cpu < 0) {
> > > > > > -               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > > +               if (cpu == -ENOENT)
> > > > > > +                       pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > >
> > > > > I don't think it is necessary to print this in the -ENOENT case, as
> > > > > there is a message for that case that will be printed anyway.
> > > >
> > > > Agree, how do you want me to progress? Should I resend patch?
> > >
> > > Yes, please.
> >
> > I looked in the code and seems like there is one place only in acpi_register_lapic() which returns
> > EINVAL without any debug prints and that flow can't be because we are providing ACPI_MADT_ENABLED
> > as an input.
> >
> > It looks like that we can safely remove the print from acpi_map_cpu().
>
> What about generic_processor_info()?  That may return -EINVAL too silently.

It returns -EINVAL for failure in allocate_logical_cpuid() only and that
function prints WARN_ONCE inside in such case. You won't miss it.

Thanks

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcmm/oAAoJEORje4g2clinhE8QAMBx0BWRJO+WIA2qmjwww4HU
dDwyrbGed3Vmd0gi0xwagXedgBf1f7ZxE1YviaZbVr9raJynlv6Ad+FYnJ7UZiIz
WhJRp2wm+vAJ1aep8Mk1o/5PcCi3f5fTiqc8qhTrATXBBYlC6BCs48wpBFs9JJi0
7rGv4p5GVyFSGUHPY8e+f+ten5fITeSFPkJlVUWbZ705+55Lbj0MNaCK3mh64+Pd
k+U2WDXK0T5jO/oePuddIeRdz6WgVsbz2stvUIyUtkWlsDQ3Ua+dpaCruaDpzmVI
6wRnHfYhGOvHqN3dekd+OXUlWxnjGJS5NTF1dQCCc71mG7f6VOQVtHII/5hFBo7A
sn7tiiv4lVDP8jAzuWW/GKW/8PQNgKFXG5uTwwJWCglra/ON469+ikYpNDeWvQ95
xk25VEZ8hnknr+G5JsUuFTnreK09Rx1gyEjiPFuJb1LS3cgqIWfvsc3jcbbFF0hb
8heK+fTFjo0pNWa1Muve4CvCXRYT0PfzGwJ0zV0CggvOOl6XMB6v+2HpL37Z5RXK
zHpsuFv+iChMCBequ478lxa+xDTgkWKF8widQag68o3+H/hTCxsK6BpQiTiWCjq5
MtqFmAxL0lSBkeR53F20DaVc+JhR/uBps+MBA5baqc9uQbeSEY6xARriqoC/Hw7Y
ptYbFHUBbVQEX/8lT/gP
=nUBx
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
