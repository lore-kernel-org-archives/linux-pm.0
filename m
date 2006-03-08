From: Pavel Machek <pavel@ucw.cz>
Subject: Re: apm for individual devices
Date: Wed, 8 Mar 2006 16:50:43 +0100
Message-ID: <20060308155043.GA3669@elf.ucw.cz>
References: <440CD773.6010401@greyinnovation.com>
	<440CE22E.8060601@greyinnovation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <440CE22E.8060601@greyinnovation.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 07-03-06 12:30:22, Tehn Yit Chin wrote:
>=20
> Tehn Yit Chin wrote:
> >Hi all,
> >
> >How does one use the sysfs entry of power/state that I can find for ea=
ch=20
> >registered device? Eg, for the i2c device on my s3c2410 cpu, I find th=
e=20
> >following entry,
> >
> >/sys/devices/platform/s3c2410-i2c/power/state
> >
> >I tried echoing "mem" into it, but nothing seems to happen.
> >
> >What I am looking for is a way of suspending and resuming individual=20
> >devices within the PM architecture?
> >
> >Any pointers would be greatly appreciated.
>=20
> After reading through the mailing list archives, I sort of work it out.=
 ie
>=20
> echo -n 1 > /sys/devices/platform/s3c2410-i2c/power/state

Actually, it is controlled by 0 and 3 these days. (0 =3D=3D on, 3 =3D=3D =
off).

								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
