From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost ACPI functionality
Date: Fri, 10 May 2013 15:10:12 +0200
Message-ID: <4720627.g9zHkFYIDJ@vostro.rjw.lan>
References: <5183EC09.9080208@gmx.de> <51842F6F.1050005@intel.com> <5184BF82.4070700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5184BF82.4070700@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, boinc_dev@ssl.berkeley.edu
List-Id: linux-pm@vger.kernel.org

On Saturday, May 04, 2013 09:57:54 AM Toralf F=C3=B6rster wrote:
> On 05/03/2013 11:43 PM, Dirk Brandewie wrote:
> > On 05/03/2013 02:26 PM, Toralf F=C3=B6rster wrote:
> >> On 05/03/2013 11:10 PM, Dirk Brandewie wrote:
> >>>
> >>> ignore_nice_load is a feature of the ondemand governor.
> >>> The intel_pstate driver is seeing the load presented by the BOINC=
 client
> >>> and is adjusting the pstate accordingly.
> >>
> >> Is the intel_pstate driver a choice for a notebook and friends whe=
re a
> >> grid software is running as a low-prio back ground job ?
> >>
> >=20
> > Probably not.
>=20
> Hhm.
>=20
> The kernel menuconfig says :
>=20
>  This driver provides a P state for Intel core processors
>  The driver implements an internal governor and will become
>  the scaling driver and governor for Sandy bridge processors.
>=20
>=20
> What shall a company like IBM with a lot of notebook installation run=
ning BOINC
> in the back ground process (World Community Grid) do - what's the con=
sequence for
> those installations if they will have that a processor ?
>=20
> In the past (few years ago and related to the ondemand governor IIRC)=
 there were
> already a longer discussion about the "nice -n 19" topic and the resu=
lt was
> to support it.
>=20
> /me Cc:'ing boinc devs, the topic might be interesting for them too.

One option might be to use the powerclamp driver along with intel_pstat=
e to
reduce the heat dissipation.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
