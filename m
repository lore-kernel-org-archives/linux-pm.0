From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 00:05:56 +0100
Message-ID: <20060105230556.GM2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35376483157601069=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============35376483157601069==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05N6ODZ008198

On =C4=8Ct 05-01-06 17:55:33, Preece Scott-PREECE wrote:
> I shouldn't oversimplify the power management in a cell phone. When I s=
aid we turned whole devices on/off, I was referring only to what the syst=
em-level PM (which uses suspend/resume) does. There's a fair amount of su=
bsystem-specific power management outside the Linux suspend/resume framew=
ork. Some of it might be handled in the framework, if the framework were =
more capable.
>=20

Ok, system-level PM is not interesting in this discussion.

You do runtime-powermanagement of devices, right? Let's take display
as an example.

(1) Do you have multiple display states like

on-fast: can refresh image every 10msec

on-slow: can only refresh image once per second, but takes less power

?

(2) Do you have multiple display states like

off-fast: display is off, user can not see anything, but it only takes
msec to wake up

off-slow: it takes 1 second for display to wake up, but it takes less
power

?

[Maybe display is bad example, but I can't think of better device with
complex power management]

								Pavel

> scott
>=20
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]=20
> Sent: Thursday, January 05, 2006 4:46 PM
> To: Preece Scott-PREECE
> Cc: Alan Stern; akpm@osdl.org; linux-pm@lists.osdl.org; linux-kernel@vg=
er.kernel.org
> Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys =
interface
>=20
> On =C4=8Ct 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> > We do have multiple system-level low-power modes. I believe today the=
y=20
> > differ in turning whole devices on or off, but there are some of thos=
e=20
> > devices that could be put in reduced-function/lowered-speed modes if=20
> > we were ready to use a finer-grained distinction.
>=20
> I think we were talking multiple off modes for _single device_. It is g=
ood to know that even cellphones can get away with whole devices on/off t=
oday.
> 								Pavel
>=20
> --
> Thanks, Sharp!

--=20
Thanks, Sharp!

--===============35376483157601069==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============35376483157601069==--
