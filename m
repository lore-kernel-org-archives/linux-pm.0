From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: linux-pm build failure
Date: Fri, 09 May 2014 23:36:03 +0200
Message-ID: <12185110.9TpRMrqnbe@vostro.rjw.lan>
References: <536BBAF8.6040601@semaphore.gr> <2930403.UViFFypGRj@vostro.rjw.lan> <536C3337.40402@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61471 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757603AbaEIVTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 17:19:22 -0400
In-Reply-To: <536C3337.40402@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, May 09, 2014 09:45:27 AM Lan Tianyu wrote:
> On 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 03:44, Rafael J. Wysocki wrote=
:
> > On Thursday, May 08, 2014 08:12:24 PM Stratos Karafotis wrote:
> >> Hi all,
> >=20
> > Hi,
> >=20
> > Thanks for the report!
> >=20
> > This is caused by commit
> >=20
> > 0e23847d5ee4 ACPICA: Export acpi_buffer_to_resource symbol
> >=20
> > merged on top of the recent ACPICA material.
> >=20
> > Lv, Tianyu, care to take care of this?
>=20
> Hi Rafael:
> 	Just check commit 51e35823eb57 and find it also exports
> acpi_buffer_to_resource symbol which commit 0e23847d5ee4 has already
> done. I think you can drop commit 0e23847d5ee4 which only exports sym=
bol
> without any other changes.

Done, thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
