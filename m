From: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 1/3] power: reset: Add Renesas reset driver
Date: Wed, 22 Feb 2017 16:04:06 +0000
Message-ID: <SG2PR06MB1165F6C78BC5F4ACA32057718A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
 <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <55cf087f-aa70-3660-1186-af9b9b20376d@roeck-us.net>
 <SG2PR06MB11650D5EE485C0F44A77E0EA8A500@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170222152815.GA23780@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170222152815.GA23780-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Guenter,

On Wednesday, February 22, 2017, Guenter Roeck wrote:
> > Looking through the drivers in the watchdog directly, I see default
> > timeouts of 20, 30, 60, and 120 seconds.
> >
> 30 and 60 are pretty common for default timeouts, though I personally
> think they are a bit long. If you want direct HW support, a maximum of 12=
0
> seconds should be sufficient though not really necessary anymore since th=
e
> core supports virtual timeouts. A maximum of at least 30 seconds would be
> needed if the watchdog is supposed to run at boot time (ie if it is
> enabled by ROMMON/BIOS and kept running by the kernel).


Thank you!
Good point about the boot time.

Chris

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
