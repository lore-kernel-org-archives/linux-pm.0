From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 21:28:31 +0200
Message-ID: <201704182128.31940@pali>
References: <20170412230854.GA11963@fury> <20170418075401.GC18887@pali> <20170418165631.GD25405@fury>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart41467196.zQCEdTFOrn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34262 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbdDRT2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 15:28:36 -0400
In-Reply-To: <20170418165631.GD25405@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Mario.Limonciello@dell.com, luto@kernel.org, kernel@kempniu.pl, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

--nextPart41467196.zQCEdTFOrn
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 18 April 2017 18:56:31 Darren Hart wrote:
> On Tue, Apr 18, 2017 at 09:54:01AM +0200, Pali Roh=C3=A1r wrote:
> > On Thursday 13 April 2017 17:39:56 Mario.Limonciello@dell.com wrote:
> > > > > No more than exists today with the dcdbas SMI interface
> > > > > (which only if you manually run userspace tools that
> > > > > manipulate the same data you can do that technically).
> > > > >=20
> > > > > We're all reasonable folks, if there is an instance of this
> > > > > that comes up we can make changes to userspace to fix it.
> > > >=20
> > > > Right. As Pali pointed out previously, if there is an existing
> > > > class driver / subsystem which supports this functionality we
> > > > should use that.
> > > >=20
> > > > I suppose one risk will be one GUID exposing both types of
> > > > methods. Those which are used by kernel drivers, and those
> > > > which have no kernel support. Or worse, methods which have
> > > > multiple behaviors depending on their input arguments.
> > > >=20
> > > > --
> > >=20
> > > Well the "most" interesting to me is the SMBIOS calling interface
> > > on the regular Dell GUID (WMBA IIRC).  That's what is used to
> > > manipulate keyboard LED timeouts in dell-laptop (although
> > > through direct SMI today).
> > >=20
> > > It's also what is used for other SMBIOS calls like changing
> > > random BIOS settings that shouldn't be generically exposed in
> > > sysfs but should be controlled by manageability tools.
> > >=20
> > > Example: turning on/off legacy option ROM or changing legacy boot
> > > order.
> >=20
> > Which basically means that new WMI /dev/ files does not help for
> > Dell.
> >=20
> > Kernel needs to manipulate with SMBIOS for implementing rfkill,
> > keyboard backlight, display brightness and also needs to receive
> > WMI events for hotkeys. So kernel modules would lock WMI interface
> > for receiving events & sending SMBIOS calls, and userspace would
> > be blocked from usage of this WMI GUID.
>=20
> This is why we can't rely on a method ID granular filter for which
> methods are exported to userspace. In my previous reply to Rafael, I
> suggested platform drivers decide which method IDs are exported, and
> for platforms with insufficient WMI method ID granularity, we will
> end up exposing methods we also use in the kernel. The WMI
> evaluation will need to be centralized and placed under mutual
> exclusion. The optional wmi evaluation filter would allow for
> drivers to audit incoming calls from userspace to ensure no
> conflict.
>=20
> It's not ideal - but I believe it addresses our reality.

Ok.

> > I do not think that we can solve this problem easily in
> > vendor-neutral interface. There was argument that WMI API was
> > designed to allow userspace applications call firmware functions
> > directly... But we are using WMI in kernel and we should not allow
> > both kernel and userspace to fight on some WMI API.
>=20
> We could drop all the in kernel wmi drivers and rely on userspace
> daemons per platform.... but I think we all agree that is not where
> we want this to go. So we'll need to find a compromise. Even then,
> we'd need to avoid competition for common method IDs across multiple
> userspace applications.

I think this is step backward. Current wmi drivers in kernel which=20
implements class devices should stay in kernel -- independently of fact=20
if they are provided by WMI API, ACPI API or direct HW access.

> > So for Dell we need for sure some Dell specific interface which
> > covers all needed functionality. I'm not sure what everything Dell
> > software needs, so what about specifying current usage of Dell
> > SMBIOS/WMI functions from existing userspace applications and also
> > planned usage in future? Then from this information we can design
> > kernel and userspace API which can fit for Dell usage.
>=20
> This was my initial response as well. The biggest problem with it is
> it places Linux imposed restrictions on the WMI mechanism, which
> will ultimately stifle innovation and/or leave Linux as a second
> class citizen for systems which rely on WMI for userspace firmware
> management.

Maybe... I agree that having WMI API for userspace application could be=20
useful, but it should not be at cost of loosing current kernel drivers=20
or kernel functionality provided by current kernel wmi drivers.

The question is, who is interested in full WMI access from userspace?=20
And who already requested it in past? I'm just asking if we are not=20
going to work on something in which nobody is interested...

Yes, we know from Mario that Dell is interested in WMI access from=20
userspace. But is there other vendor? At least I do not know, so this is=20
reason why I suggested to rather create API specially for Dell which=20
will fully fit for both userspace Dell applications and also kernel dell=20
wmi drivers to minimize conflicts.

I'm sure that specific API/ABI designed for concrete usage (here in=20
Dell) would be easier and also better in resolving conflicts and=20
fighting between kernel & userspace as some fully generic API/ABI which=20
needs to be designed for everything and everybody.

What worry me is that there will be kernel wmi drivers which due to=20
conflicts in locking/usage would not be able to allow userspace to=20
access WMI. Or if their implemented filter would not fullfit for vendor=20
userspace application (for some reasons), and vendor userspace=20
application starts blocking kernel wmi modules. This would mean that=20
user would be in position where must decide if he wants: stable kernel=20
driver for controlling rfkill/led and receive hotkey presses OR=20
userspace application which can control charging, setting special BIOS=20
settings/etc/... And if laptop vendors do not want to coordinate work=20
with kernel upstream, this situation can really happen.

> > About other vendor WMI's functions... I'm not sure, but there is
> > again possibility that rfkill, leds or hotkeys would exists on
> > same WMI GUID as other maintenance functions (which userspace
> > wants), so export would be again blocked by kernel module for
> > rfkill/leds/hotkeys.
> >=20
> > Therefore I'm not really sure if some /dev/wmi* API would be
> > usefull, and not always blocked by kernel module which implements
> > rfkill support.
>=20
> I'd like to also point out that the Linux kernel has a minimal and
> targeted set of WMI drivers generally aimed at making laptops work
> as expected through the only mechanism we had access to.

Yes, that is truth for obvious reason.

> To my
> knowledge, we never sat down to discuss how WMI should be
> implemented in the Linux ecosystem. That leaves us in the situation
> we are in today, in which Linux essentially took the most expedient
> route to making laptops work - which happened to be WMI, but we
> didn't consider the broader implications of that mechanism or how
> what we implemented would interact with full set of functionality
> provided by WMI.

I did not know about any discussion too.

> So our challenge now is to look at WMI as a whole. How should it be
> implemented to achieve feature parity. And then consider how the
> existing drivers fit into that. Please see my proposal in response
> to Rafael's latest reply. I believe it outlines a reasonable
> compromise.

Ok, I will write there other notes.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart41467196.zQCEdTFOrn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlj2aN8ACgkQi/DJPQPkQ1JxPQCdE6e7kKERc3zGtRB28y5lzTMJ
/eYAn3zOb3owJsbtaui9M7Dj4k0hK9tb
=NUWj
-----END PGP SIGNATURE-----

--nextPart41467196.zQCEdTFOrn--
