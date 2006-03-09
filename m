From: Pavel Machek <pavel@suse.cz>
Subject: Re: apm for individual devices
Date: Thu, 9 Mar 2006 02:55:18 +0100
Message-ID: <20060309015518.GE2084@elf.ucw.cz>
References: <105E3883E4A2524BB0B1281D1599C473CA93F8@zmy16exm62.ds.mot.com>
	<20060308155153.GB3669@elf.ucw.cz>
	<440F8B96.5080802@greyinnovation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26296295944025672=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <440F8B96.5080802@greyinnovation.com>
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
Cc: Li Qiang-E3422C <E3422C@motorola.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============26296295944025672==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k291tWDZ007169

On =C4=8Ct 09-03-06 12:57:42, Tehn Yit Chin wrote:
> Pavel Machek wrote:
> >On =C3=9At 07-03-06 10:11:31, Li Qiang-E3422C wrote:
> >
> >>'0' indicates the device is on. Other values (1-3) indicate the devic=
e
> >>is in a low power state.=20
> >>You can see ACPI's spec.
> >
> >
> >Actually, no. This is broken interface, please do not use it. 0 =3D=3D=
 on,
> >2 or 3 =3D=3D off. But do not use it.
>=20
> Are you saying not to the the power/state that is present in the=20
> device's sysfs entry? What interface do you recommend that I use?

Parse error. But I'm trying to say that <device>/power/state should
not be used -- it is ugly/broken. Replacement interface is being
prepared by Patrick, I believe, but is not yet in mainline. Feel free
to help Patrick :-).

								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

--===============26296295944025672==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============26296295944025672==--
