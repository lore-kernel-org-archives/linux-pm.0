From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 13:21:31 +0100
Message-ID: <20060210122131.GC4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060209085344.GF16052@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060209085344.GF16052@boogie.lpds.sztaki.hu>
Sender: linux-acpi-owner@vger.kernel.org
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On =C4=8Ct 09-02-06 09:53:44, Gabor Gombas wrote:
> On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:
>=20
> > The backlight interface only supports exporting and setting the cur=
rent=20
> > brightness. For various bits of hardware, the AC and DC brightnesse=
s are=20
> > stored separately. Drivers would need to know which brightness valu=
e to=20
> > export to userspace. I have an HP backlight driver here which would=
=20
> > benefit from this, and I'm looking at the same issue for a Panasoni=
c=20
> > one.
>=20
> I don't know the backlight interface but extending it to export all
> available brightness values would seem more logical to me.
>=20
> If I'd had a laptop I'd hate if I could only set the DC brightness if=
 I
> plug out the AC power.

Still "set current brightness" operation makes a lot of sense.
								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
