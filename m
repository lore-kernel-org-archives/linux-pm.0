From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sysinterface
Date: Thu, 5 Jan 2006 23:32:44 +0100
Message-ID: <20060105223244.GI2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============032959050301802684=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============032959050301802684==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05MWuDZ006018

On =C4=8Ct 05-01-06 17:28:28, Preece Scott-PREECE wrote:
> =20
> Not sure if this is the kind of example you're looking for, but...
>=20
> We do have devices that may need to stay alive even though the processo=
r has been suspended - for instance, we keep the display backlight on for=
 human-useful periods following the last keypress, but most of the system=
 can be shut down as soon as the work driven from the keypress is finishe=
d. The display needs to be able to maintain itself without the processor'=
s help.
>=20

No, not that one. That would be more like processor Cx states on PC.

Are there any devices that have multiple "off" modes with
different "latency before device gets functional" values, where we
actually want to use more than one "off" mode?
							Pavel

--=20
Thanks, Sharp!

--===============032959050301802684==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============032959050301802684==--
