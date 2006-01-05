From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 23:44:04 +0100
Message-ID: <20060105224403.GJ2095@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<Pine.LNX.4.50.0601051359290.10834-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74263733273110044=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051359290.10834-100000@monsoon.he.net>
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

--===============74263733273110044==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05MiaDZ006785

On =C4=8Ct 05-01-06 14:15:39, Patrick Mochel wrote:
>=20
> On Thu, 5 Jan 2006, Pavel Machek wrote:
>=20
> > Do you have the patch to filter bad values? I submitted one. You
> > rejected it, because it does not support D1. Never mind that original
> > code does not support D1, either. [Should I retransmit the patch?]
>=20
> No, I offered guidance in one of the first emails. The code that export=
s a
> 'power' file for every single device from the driver model core should =
be
> removed.
>=20
> It should be replaced with a file exported by the bus driver that expor=
ts
> the actual states that the device supports. The parsing can easily happ=
en
> at this point, because the bus knows what a good value is.

(1) would change core<->driver interface

(2) is quite a lot of work

(3) ...with very little benefit, until drivers support >2 states

I want to fix invalid values being passed down to drivers, not rewrite
half of driver model.

If you want to rewrite driver model for >2 states, great, but that is
going to take at least a year AFAICS, so please let me at least fix
the bugs in meantime.

> > If you suggest to just add check for =3D=3D 0 or =3D=3D 2... I think =
I can do
> > that, but that's going to break userspace, anyway (it passes _3_
> > there) and have no reasonable path to sane interface.
>=20
> The userspace interface is broken. We can keep it for compatability
> reasons, but there needs to be a new interface.

I assumed we could fix the interface without actually introducing >2
states support. That can be done in reasonable ammount of code.=20

> > > If we export exactly the device states that a device supports, then
> > >we can
> >
> > Exporting multiple states is quite a lot of code, and it needs driver
> > changes. There's no clear benefit.
>=20
> I don't understand what you're saying. If I have a driver that Iwant to
                                         ~~~~~~~~~~~~~~~~~~
> make support another power state and I'm willing to write that code, th=
en
> there is a clear benefit to having the infrastructure for it to "just
> work".

I do not see such drivers around me, that's all. It seems fair to me
that first driver author wanting that is the one who introduces >2
states support to generic infrastructure.

> If you want a more concrete example, consider the possibility where it =
may
> be possible to reinitialize the device from D1 or D2, but not from D3. =
For
> the radeon, this is true in some cases (if I understand Ben H
> correctly).

...which seems like one more reason to only export "on" and "off" in
radeon case. We don't want userspace to write "D3" to radeon, then
wondering why it failed.

Passing "on"/"off" down to radeon lets the driver decide what power
state it should enter.
								Pavel
--=20
Thanks, Sharp!

--===============74263733273110044==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============74263733273110044==--
