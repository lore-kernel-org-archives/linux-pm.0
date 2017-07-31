From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag from
 struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 00:16:45 +0200
Message-ID: <20170731221645.GA5871@light.dominikbrodowski.net>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Winkler, Tomas" <tomas.winkler@intel.com>, rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, bhelgaas@google.com
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rafael, Mika, Bjorn and Tomas,

can't explain exactly what causes breakage between MEI and PM first seen on
v4.13-rc2 (ther was a typo in the orignal message), but I was able to bisect
it down to commit

[de3ef1eb1cd0cc3a75f7a3661e10ed827f370ab8] PM / core: Drop run_wake flag fr=
om struct dev_pm_info

Here's the original bug report with the reply by the maintainer:

On Sun, Jul 30, 2017 at 09:16:56AM +0000, Winkler, Tomas wrote:
> > -----Original Message-----
> > From: Dominik Brodowski [mailto:linux@dominikbrodowski.net]
> > Sent: Sunday, July 30, 2017 11:59
> > To: Winkler, Tomas <tomas.winkler@intel.com>
> > Cc: Usyskin, Alexander <alexander.usyskin@intel.com>; linux-
> > kernel@vger.kernel.org
> > Subject: MEI-related WARN_ON() triggered during resume-from-sleep on
> > v4.12-rc2+
> >=20
> > Thomas,
> >=20
> > on Linus' most recent kernel (v4.12-rc2, git head 0a07b238e5f48), I see=
 the
> > following message on my Dell XPS13 when resuming from sleep. MEI is,
> > AFAIK, not being used on this system:
> >
>=20
> Thanks for the report,  we haven't change the logic of this code since 4.=
12 so we need to look for=20
> changes  in pci and/or pm subsystems.  We try to bisect it.=20
>=20
> Thanks
>=20
>=20
> =20
> > [  192.940537] Restarting tasks ...
> > [  192.940610] PGI is not set
> > [  192.940619] ------------[ cut here ]------------ [  192.940623] WARN=
ING: CPU: 0
> > PID: 1661 at /home/brodo/local/kernel/git/linux/drivers/misc/mei/hw-
> > me.c:653 mei_me_pg_exit_sync+0x351/0x360 [  192.940624] Modules linked
> > in:
> > [  192.940627] CPU: 0 PID: 1661 Comm: kworker/0:3 Not tainted 4.13.0-rc=
2+
> > #2 [  192.940628] Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11
> > 12/08/2016 [  192.940630] Workqueue: pm pm_runtime_work <snip> [
> > 192.940642] Call Trace:
> > [  192.940646]  ? pci_pme_active+0x1de/0x1f0 [  192.940649]  ?
> > pci_restore_standard_config+0x50/0x50
> > [  192.940651]  ? kfree+0x172/0x190
> > [  192.940653]  ? kfree+0x172/0x190
> > [  192.940655]  ? pci_restore_standard_config+0x50/0x50
> > [  192.940663]  mei_me_pm_runtime_resume+0x3f/0xc0
> > [  192.940665]  pci_pm_runtime_resume+0x7a/0xa0 [  192.940667]
> > __rpm_callback+0xb9/0x1e0 [  192.940668]  ?
> > preempt_count_add+0x6d/0xc0 [  192.940670]  rpm_callback+0x24/0x90 [
> > 192.940672]  ? pci_restore_standard_config+0x50/0x50
> > [  192.940674]  rpm_resume+0x4e8/0x800
> > [  192.940676]  pm_runtime_work+0x55/0xb0 [  192.940678]
> > process_one_work+0x184/0x3e0 [  192.940680]  worker_thread+0x4d/0x3a0 [
> > 192.940681]  ? preempt_count_sub+0x9b/0x100 [  192.940683]
> > kthread+0x122/0x140 [  192.940684]  ? process_one_work+0x3e0/0x3e0 [
> > 192.940685]  ? __kthread_create_on_node+0x1a0/0x1a0
> > [  192.940688]  ret_from_fork+0x27/0x40
> > [  192.940690] Code: 96 3a 9e ff 48 8b 7d 98 e8 cd 21 58 00 83 bb bc 01=
 00 00
> > 04 0f 85 40 fe ff ff e9 41 fe ff ff 48 c7 c7 5f 04 99 96 e8 93 6b 9f ff=
 <0f> ff e9 5d
> > fd ff ff e8 33 fe 99 ff 0f 1f 00 0f 1f 44 00 00 55 [  192.940719] ---[ =
end trace
> > a86955597774ead8 ]--- [  192.942540] done.
> >=20
> > This doesn't / didn't happen on v4.12.


By using the dynamic_debug infrastructure, I was able to obtain a few more
data points:

Running 0847684cfc5f, when suspending the system to ram and resuming again,
I see the following messages:

	[  614.936773] sd 3:0:0:0: [sda] Stopping disk
	[  614.956004] mei_me 0000:00:16.0: rpm: me: runtime resume
	[  614.956165] ACPI : EC: event blocked
	[  614.980164] mei_me 0000:00:16.0: interrupt source 0x00000002
	[  614.980191] mei_me 0000:00:16.0: function called after ISR to handle th=
e interrupt processing.
	...
	[  615.266896] Suspended for 1.190 seconds
	...
	[  615.455775] sd 3:0:0:0: [sda] Starting disk
	[  615.455855] mei_me 0000:00:16.0: interrupt source 0x00000002
	[  615.455870] mei_me 0000:00:16.0: function called after ISR to handle th=
e interrupt processing.
	[  615.455877] mei_me 0000:00:16.0: we need to start the dev.

and everything works fine as expected (no WARN(), no stack trace, nothing
dubious).

Running de3ef1eb1cd0 instead, when suspending, I see *no* mei_me-related
message. During resume, the stack trace already noted above for
v4.13-rc2+ appears again:

	[   80.333909] sd 3:0:0:0: [sda] Stopping disk
	[   80.535777] psmouse serio1: Failed to disable mouse on isa0060/serio1
	[   80.983510] ACPI : EC: event blocked
	[   81.065510] PM: suspend of devices complete after 734.074 msecs
	...
	[   82.137038] Restarting tasks ...=20
	[   82.143986] mei_me 0000:00:16.0: rpm: me: runtime resume
	[   82.143989] PGI is not set
	[   82.144001] ------------[ cut here ]------------
	[   82.144008] WARNING: CPU: 3 PID: 1881 at /home/brodo/local/kernel/git/l=
inux/drivers/misc/mei/hw-me.c:653 mei_me_pg_exit_sync+0x351/0x360
	[   82.144009] Modules linked in:
	[   82.144012] CPU: 3 PID: 1881 Comm: kworker/3:5 Not tainted 4.12.0-rc5+ =
#3
	[   82.144013] Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08=
/2016
	...
	[   82.144017] Workqueue: pm pm_runtime_work
	[   82.144019] task: ffff964a91b35700 task.stack: ffffa51b43508000
	[   82.144022] RIP: 0010:mei_me_pg_exit_sync+0x351/0x360
	...
	[   82.144156] ---[ end trace 5827b2fcedec4bc9 ]---
	[   82.144272] done.
	...
	[   83.194425] mei_me 0000:00:16.0: rpm: me: runtime resume ret =3D -62
	[   83.194460] mei_me 0000:00:16.0: unexpected reset: dev_state =3D ENABLE=
D fw status =3D 1E000245 6000A106 00000200 00004400 00000101 43C00ED9
	...

Any ideas?

Best,
	Dominik


PS @Tomas: Sorry for mistyping your first name in the previous message.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAll/rEoACgkQmpdgiUyN
ow2LhxAAly40PrpNl5xHmSkSgmF6TxFxa6TbL674EfNzsIDELpLpthv9YkHx+q5d
yRa1hwUgQo+0SV3Atc6kcObAuStcEdimwkb28Y82vcZx+ErCyeSj777bzKXSv3Eb
xsEMNAshsy4hMTRfHDkj/Mc0jEo9i8PUllG80AqMSUCxcUPz5hYis1jPHMWXjB1+
kKa8Dhhv1fXU++RfmNuV/ZOJP2N7ZvX4nnGtTdSKD4pNcs7TI9BmoGVyAzu+ENAW
5uFbJQCdj5uWVscRhpa5tiaJdvJyHUo4ZncyXy14AufHt0ou8w7IXbtf6B4Qhbr1
exCYsWVizrfkcmp4IecGxY2KeyRfw9sFexnM3di3Ytze8Y4VHMdpyCDhUEsYF7XS
DO8/G43XGnTIX+4ZSU79JiocbCi+h/vgM213lUUY0jDkxQYki9jhH4bDAz2vfGz+
UqFJhfEYrZLHB7PYIFE+F3A7oiz3d0MqvHnZvlx6xcE0lJBkOZm0hGEr/YPAIamy
EUQwExlcptHOWUdvQXyz54FiUZ5I+mRa0dFXTRdPMG0fPWuzpPoI7Rc4+XB/42Z9
X7VyOOiiGy+QocJ7PKf/qBcd0MdkDI11z0zz1XgC85mNFM2rD6siRX3NMFiQ3MCv
Ug8tRvea9E2wve+lY35bkxbLsBP9uSXJ7PZ2LzWQkQCuxXO37YI=
=2djG
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
