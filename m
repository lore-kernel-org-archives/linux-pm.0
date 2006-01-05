From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 22:55:29 +0100
Message-ID: <20060105215528.GF2095@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37156290681739357=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============37156290681739357==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05LtrDZ003896

On =C4=8Ct 05-01-06 13:42:33, Patrick Mochel wrote:
>=20
> On Wed, 4 Jan 2006, Pavel Machek wrote:
>=20
> > On =C3=9At 27-12-05 20:22:04, Patrick Mochel wrote:
>=20
> > > Heh, not really. You're not really solving any problems, only givin=
g the
> > > illusion that you've actually fixed something.
> >
> > Except perhaps userspace passing invalid values down to drivers in
> > pm_message_t.event?
>=20
> It is up to the layer parsing the value to filter out bad values.

Do you have the patch to filter bad values? I submitted one. You
rejected it, because it does not support D1. Never mind that original
code does not support D1, either. [Should I retransmit the patch?]

If you suggest to just add check for =3D=3D 0 or =3D=3D 2... I think I ca=
n do
that, but that's going to break userspace, anyway (it passes _3_
there) and have no reasonable path to sane interface.

> > > As I mentioned in the thread (currently happening, BTW) on the linu=
x-pm
> > > list, what you want to do is accept a string that reflects an actua=
l state
> > > that the device supports. For PCI devices that support low-power st=
ates,
> > > this would be "D1", "D2", "D3", etc. For USB devices, which only su=
pport
> > > an "on" and "suspended" state, the values that this patch parses wo=
uld
> > > actually work.
> >
> > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> > and I'm not sure about those "D1" and "D2" parts. Userspace should no=
t
> > have to know about details, it will mostly use "on"/"suspend" anyway.
>=20
> D0 - D3 are common for all PCI devices. "on" and "suspend" are not devi=
ce
> states. They are conceptual representations of device states.
>=20
> I understand where you are coming from. Most users will only care that =
a
> particular device is "on" or "off". That is fine. They will click throu=
gh
> a gui that turns off a device and never think any more about it.
>=20
> However, we are not developing an interface for end-users. We're
> developing an interface that the guis may use. And, along with the guis=
,
> there are also people that care about everything in between "on" and
> "suspend".

There may be more than "D1" and "D2" between "D0" and "D3". There may
be two different ways to put particular device into D1 sleep. This
means buses and devices contributing states, and all this is
complexity noone really wants.

> If we export exactly the device states that a device supports, then
>we can

Exporting multiple states is quite a lot of code, and it needs driver
changes. There's no clear benefit.

> I have a firewire controller in a desktop system, and a ATI Radeon in a
> T42 that support D1 and D2..

Ok, now we have a concrete example. So Radeon supports D1. But putting
radeon into D1 means you probably want to blank your screen and turn
the backlight off; that takes *long* time anyway. So you can simply
put your radeon into D3 and save a bit more power.

So yes, Radeon supports D1, but we probably do not want to use it.

[You may still want to do D1 on radeon for
debugging/testing/something. Fine, but we are trying to build
power-management infrastructure, not debugging one.]

								Pavel
--=20
Thanks, Sharp!

--===============37156290681739357==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============37156290681739357==--
