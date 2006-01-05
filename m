From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: [patch] pm: fix runtime powermanagement's /sysinterface
Date: Thu, 5 Jan 2006 17:28:28 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============078451209643615183=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============078451209643615183==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05MSYDZ005651

=20
Not sure if this is the kind of example you're looking for, but...

We do have devices that may need to stay alive even though the processor =
has been suspended - for instance, we keep the display backlight on for h=
uman-useful periods following the last keypress, but most of the system c=
an be shut down as soon as the work driven from the keypress is finished.=
 The display needs to be able to maintain itself without the processor's =
help.

Scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org [mailto:linux-pm-bounces@lists.osdl=
.org] On Behalf Of Pavel Machek
Sent: Thursday, January 05, 2006 3:55 PM
To: Patrick Mochel
On =C8t 05-01-06 13:42:33, Patrick Mochel wrote:
>=20

> I have a firewire controller in a desktop system, and a ATI Radeon in=20
> a
> T42 that support D1 and D2..

Ok, now we have a concrete example. So Radeon supports D1. But putting ra=
deon into D1 means you probably want to blank your screen and turn the ba=
cklight off; that takes *long* time anyway. So you can simply put your ra=
deon into D3 and save a bit more power.

So yes, Radeon supports D1, but we probably do not want to use it.

[You may still want to do D1 on radeon for debugging/testing/something. F=
ine, but we are trying to build power-management infrastructure, not debu=
gging one.]

								Pavel
--
Thanks, Sharp!


--===============078451209643615183==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============078451209643615183==--
