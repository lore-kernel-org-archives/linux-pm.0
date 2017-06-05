From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent Dell systems
Date: Mon, 5 Jun 2017 15:18:59 +0000
Message-ID: <806f96fe75d84268a570b702490c686c@ausx13mpc120.AMER.DELL.COM>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
 <3454366.uzaJljlWGm@aspire.rjw.lan> <2944956.jYmHlBxMl3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:54681 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751077AbdFEPTC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 11:19:02 -0400
In-Reply-To: <2944956.jYmHlBxMl3@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, mika.westerberg@linux.intel.com

> +	/*
> +	 * Enable the EC to wake up the system from suspend-to-idle to allow
> +	 * power button events to it wake up.
> +	 */
> +	{
> +	 .callback =3D init_ec_gpe_wakeup,
> +	 .ident =3D "Dell XPS 13 9360",
> +	 .matches =3D {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
> +		},
> +	},
> +	{
> +	 .callback =3D init_ec_gpe_wakeup,
> +	 .ident =3D "Dell XPS 13 9365",
> +	 .matches =3D {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9365"),
> +		},
> +	},
>  	{},
>  };
>=20

Although the XPS 9360 and XPS 9365 are currently the only Dell products on
the market that do the wakeup this way, this is part of Dell's BIOS and EC
codebase.  As other Dell products start to ship Windows 10 with Modern Stan=
dby
and (eventually) Linux with Suspend-to-Idle I'd expect this list to be grow=
ing.

I know that we talked about this previously in relation to the EC notificat=
ion
of going in to suspend-to-idle and you had instead marked it across all Del=
l Inc systems.

Rather than hardcode a whitelist of platform that can do this, could you do=
 the
same thing here and allow EC wakeups across Dell Inc. systems?

Thanks,
