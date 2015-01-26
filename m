From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: pwoertop frequencies not ordered descending
Date: Mon, 26 Jan 2015 15:30:41 +0100
Message-ID: <7198242.H54ftQFeuz@vostro.rjw.lan>
References: <54C6474E.6080805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52901 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751910AbbAZOH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 09:07:58 -0500
In-Reply-To: <54C6474E.6080805@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "linux-pm >> Linux PM list" <linux-pm@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>

Cc: Kristen

On Monday, January 26, 2015 02:55:26 PM Toralf F=C3=B6rster wrote:
> With the ACPI driver (and CPU governor "ondemand") the output of powe=
rtop looked always fine.
> However with the P-State driver I do now have this output at 2 harden=
ed 64 bit Gentoo Linux systems:
>=20
>=20
> PowerTOP 2.6      Overview   Idle stats   Frequency stats   Device st=
ats   Tunables                    =20
>=20
>=20
>             Package |             Core    |            CPU 0       CP=
U 1
>                     |                     | Actual    2.6 GHz     2.7=
 GHz
> Idle         0.3%   | Idle        63.2%   | Idle        73.9%       7=
5.0%
> 2.50 GHz     0.1%   | 2.50 GHz     0.1%   | 2.50 GHz     0.1%        =
0.0%
> 2.60 GHz     9.0%   | 2.60 GHz     8.9%   | 2.60 GHz     8.9%        =
0.3%
> 2.90 GHz    74.5%   | 2.90 GHz    13.4%   | 2.90 GHz     5.4%       1=
1.3%
> 2.71 GHz    13.5%   | 2.71 GHz    12.9%   | 2.71 GHz    11.2%       1=
2.3%
>  800 MHz     0.2%   |  800 MHz     0.1%   | 2.81 GHz     0.5%        =
0.1%
> 2.81 GHz     2.3%   | 2.81 GHz     1.1%   | 1200 MHz     0.0%        =
0.9%
>  900 MHz     0.0%   | 1000 MHz     0.1%   | 1100 MHz     0.0%        =
0.1%
> 1000 MHz     0.1%   | 1200 MHz     0.0%   | 1000 MHz     0.0%        =
0.0%
> 1200 MHz     0.0%   |  900 MHz     0.0%   |  800 MHz     0.0%        =
0.0%
> 1100 MHz     0.0%   | 1100 MHz     0.0%   |  900 MHz     0.0%        =
0.0%
> 1300 MHz     0.0%   | 1500 MHz     0.0%   |                          =
0.0%
> 1500 MHz     0.0%   | 1400 MHz     0.0%   |                          =
0.0%
> 1400 MHz     0.0%   |                     |
>=20
>                     |             Core    |            CPU 2       CP=
U 3
>                     |                     | Actual    2.8 GHz     2.8=
 GHz
>                     | Idle         6.6%   | Idle        23.1%       2=
4.9%
>                     | 2.50 GHz     0.1%   | 2.50 GHz     0.0%        =
0.1%
>                     | 2.60 GHz     8.9%   | 2.60 GHz     0.1%        =
8.9%
>                     | 2.90 GHz    69.1%   | 2.90 GHz    62.9%       6=
2.5%
>=20
> Is this (partly ?) related to the kernel or just an issue of powertop=
 ?
>=20
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
