From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 3/3] thinkpad_acpi: document the
 battery controls
Date: Mon, 14 May 2018 09:03:02 -0300
Message-ID: <20180514120302.knhohskga6x6ji3s@khazad-dum.debian.net>
References: <20180513153024.GA5142@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180513153024.GA5142@thinkpad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 May 2018, Ognjen Galic wrote:
> +Battery force discharging
> +--------------------------
> +
> +There is also support for AC overriding. This means that you can force the battery to discharge
> +even when AC is attached. This is also exposed via the generic ACPI driver:
> +
> +/sys/class/power_supply/BATx/force_discharge [int, 1, 0]
> +
> +Setting it to 1 forces the battery to discharge on AC.

This is used to run a battery "fuel gauge" callibration cycle.

One has to set the limits to 0,100 (i.e. disable the anti-wear
limiters), trigger a force_discharge, and wait until it discharges to
zero.  At that point, the EC is supposed to reset the force_discharge
bit by itself, and then you have to wait the battery to charge back to
full.

(and at least on older thinkpads, where you had to use SMAPI to do the
above, it didn't need much help from the operating system.  Once a
couple years you could just set force_discharge on both batteries (with
the thing connected to AC), shutdown the operating system, and go to
sleep.  By morning, it would be fully charged and both gauges
calibrated, still powered off, ready to go :P ).

-- 
  Henrique Holschuh

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
