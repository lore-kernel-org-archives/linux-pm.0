From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Mon, 23 Feb 2015 07:38:53 +0000
Message-ID: <F54AEECA5E2B9541821D670476DAE19C2B8AC650@PGSMSX102.gar.corp.intel.com>
References: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com>
 <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
 <AF233D1473C1364ABD51D28909A1B1B73274624E@PGSMSX105.gar.corp.intel.com>
 <F54AEECA5E2B9541821D670476DAE19C2B8AB1FC@PGSMSX102.gar.corp.intel.com>
 <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbBWHi6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 02:38:58 -0500
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ong, Boon Leong" <boon.leong.ong@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <pure.logic@nexus-software.ie>

> -----Original Message-----
> From: Ong, Boon Leong
> Sent: Monday, February 23, 2015 9:39 AM
> Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal drive=
r
>=20
> >Just to bring out for discussion, do you think we should put a "safe=
ty range"
> >for reporting out the critical trip temperature value (mean the valu=
e from
> >register minus 1 or 2 degree)?
> >
> >Just wondering if this is needed for the software to have the suffic=
ient
> >shutdown time before the HW make a hard power cut off when the
> >critical trip point is reached.
>=20
> I assume that the suggestion is meant for the case where thermal regi=
ster is
> not locked by BIOS. It is not a bad idea to have some protection agai=
nst
> wrong configuration on critical trip point by user.
> Looking through the data-sheet in Quark, I could not find an recommen=
ded
> temperature. So, I propose that we use the same value set by BIOS tod=
ay
> - 105C as the maximum.

What I mean here is that even the BIOS locks it and used the maximum va=
lue
105 =B0C for the critical trip point, should we -1 or -2 (104/103 =B0C)=
 in this driver
to let the system shut down before the actual trip point hit, in case t=
he HW
performs a HW power cut off before the Linux kernel has enough time to
shut down properly?

>=20
> > > +static struct soc_sensor_entry *alloc_soc_dts(void)
> > > +{
> > > +	struct soc_sensor_entry *aux_entry;
> > > +	int err;
> > > +	u32 out;
> > > +	int wr_mask;
> > > +
> > > +	aux_entry =3D kzalloc(sizeof(*aux_entry), GFP_KERNEL);
> >
> >Wondering is it possible to use the resource-managed functions (for =
e.g.
> >devm_kzalloc())? This could help the driver looks more neat and clea=
n
> >where the resource-managed framework will help you take care all the
> >kfree().
> >
> >Understand that the flow here is to call the thermal_zone_device_reg=
ister()
> >function after this aux_entry allocation.
> >
> >But thinking would it also working if change the flow to call
> >thermal_zone_device_register() function 1st to obtain the
> >thermal_zone_device
> >then later on perform devm_kzalloc() and assign it back to devdata.
> >
> Ok, it is worth exploring on this devm_kzalloc() for neatness.
> Thanks!

