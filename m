From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] intel_telemetry_debugfs: fix oops found while
 load/unload module test
Date: Sat, 27 May 2017 08:54:30 +0200
Message-ID: <20170527065430.GA24739@amd>
References: <6718d6200ee45ae58b496225d148d275a2776756.1495897832.git.priyalee.kushwaha@intel.com>
 <20170527054929.GA118811@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170527054929.GA118811@localhost.localdomain>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: priyalee.kushwaha@intel.com, souvik.k.chakravarty@intel.com, andy@infradead.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Sat, May 27, 2017 at 08:17:39AM -0700, priyalee.kushwaha@intel.com wro=
te:
> > From: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
> >=20
> > This fix oops found while testing load/unload test of
> > intel_telemetry_debugfs module. Module_init uses register_pm_notifier
> > for PM callbacks, but unregister_pm_notifier was missing from
> > module_exit.
> >=20
> >  [ 97.481860] BUG: unable to handle kernel paging request at ffffffffa0=
06f010
> >  [ 97.489742] IP: blocking_notifier_chain_register+0x3a/0xa0
> >  [ 97.495898] PGD 2e0a067
> >  [ 97.495899] PUD 2e0b063
> >  [ 97.498737] PMD 179e29067
> >  [ 97.501573] PTE 0
> >=20
> >  [ 97.508423] Oops: 0000 1 PREEMPT SMP
> >  [ 97.512724] Modules linked in: intel_telemetry_debugfs intel_rapl gpi=
o_keys dwc3 udc_core intel_telemetry_pltdrv intel_punit_ipc intel_telemetry=
_core rtc_cmos efivars x86_pkg_temp_thermal iwlwifi snd_hda_codec_hdmi soc_=
button_array btusb cfg80211 btrtl mei_me hci_uart btbcm mei btintel i915 bl=
uetooth intel_pmc_ipc snd_hda_intel spi_pxa2xx_platform snd_hda_codec dwc3_=
pci snd_hda_core tpm_tis tpm_tis_core tpm efivarfs
> >  [ 97.558453] CPU: 0 PID: 889 Comm: modprobe Not tainted 4.11.0-rc6-int=
el-dev-bkc #1
> >  [ 97.566950] Hardware name: Intel Corp. Joule DVT3/SDS, BIOS GTPP181A.=
X64.0143.B30.1701132137 01/13/2017
> >  [ 97.577518] task: ffff8801793a21c0 task.stack: ffff8801793f0000
> >  [ 97.584162] RIP: 0010:blocking_notifier_chain_register+0x3a/0xa0
> >  [ 97.590903] RSP: 0018:ffff8801793f3c58 EFLAGS: 00010286
> >  [ 97.596802] RAX: ffffffffa006f000 RBX: ffffffff81e3ea20 RCX: 00000000=
00000000
> >  [ 97.604812] RDX: ffff880179eaf210 RSI: ffffffffa0131000 RDI: ffffffff=
81e3ea20
> >  [ 97.612821] RBP: ffff8801793f3c68 R08: 0000000000000006 R09: 00000000=
0000005c
> >  [ 97.620847] R10: 0000000000000000 R11: 0000000000000006 R12: ffffffff=
a0131000
> >  [ 97.628855] R13: 0000000000000000 R14: ffff880176e35f48 R15: ffff8801=
793f3ea8
> >  [ 97.636865] FS: 00007f7eeba07700(0000) GS:ffff88017fc00000(0000) knlG=
S:0000000000000000
> >  [ 97.645948] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  [ 97.652423] CR2: ffffffffa006f010 CR3: 00000001775ef000 CR4: 00000000=
003406f0
> >  [ 97.660423] Call Trace:
> >  [ 97.663166] ? 0xffffffffa0031000
> >  [ 97.666885] register_pm_notifier+0x18/0x20
> >  [ 97.671581] telemetry_debugfs_init+0x92/0x1000
> >=20
> > Signed-off-by: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
>=20
> Hi Priyalee,
>=20
> Thanks for catching this, we should get a fix into the RC cycle. but I th=
ink we
> can make some small changes that will improve legibility here.
>=20
> > ---
> >  drivers/platform/x86/intel_telemetry_debugfs.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/p=
latform/x86/intel_telemetry_debugfs.c
> > index ef29f18..0f93975 100644
> > --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> > +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> > @@ -966,8 +966,12 @@ static int __init telemetry_debugfs_init(void)
> >  #endif /* CONFIG_PM_SLEEP */
> > =20
> >  	debugfs_conf->telemetry_dbg_dir =3D debugfs_create_dir("telemetry", N=
ULL);
> > -	if (!debugfs_conf->telemetry_dbg_dir)
> > +	if (!debugfs_conf->telemetry_dbg_dir) {
> > +#ifdef CONFIG_PM_SLEEP
> > +		unregister_pm_notifier(&pm_notifier);
> > +#endif /* CONFIG_PM_SLEEP */
> >  		return -ENOMEM;
> > +	}
>=20
> As a general rule, we try to avoid peppering code with #ifdef blocks, and=
 prefer
> to create no-op functions, or similar. CONFIG_PM_SLEEP unfortunately does=
n't
> have such no-op functions.
>=20
> Rather than add the CONFIG_PM_SLEEP block above, please convert the above=
 to use
> an err=3D and goto statement, and create the appropriate labels below.
>=20
> +Rafael, Len, Pavel, linux-pm: Is there a preferred approach for dealing =
with
>                                CONFIG_PM_SLEEP?

Yeah, empty "unregister_pm_notifier" in !CONFIG_PM_SLEEP case sounds
like a good idea.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkpIqUACgkQMOfwapXb+vJCIwCgvDw6N/XCJNJpO3C8uZl0JFS3
HDAAoKn/wsmT3Q+5eIlkZ927fNxw7Gj0
=jANW
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
