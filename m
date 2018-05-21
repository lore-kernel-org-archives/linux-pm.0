From: Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>
Subject: Re: [PATCH 2/3] thinkpad_acpi: add support for
 force_discharge
Date: Mon, 21 May 2018 07:31:12 -0600
Message-ID: <20180521133112.GA4578@kevinolos>
References: <20180513153000.GA5117@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180513153000.GA5117@thinkpad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2018-05-13 at 17:30 +0200, Ognjen Galic wrote:
> Lenovo ThinkPad systems have a feature that lets you
> force the battery to discharge regardless if AC is attached
> or not.
> 
> This patch implements that feature and exposes it via the generic
> ACPI battery driver.

On a T430 (2342-CTO) I can confirm that both force_discharge and
inhibit_charge behave as expected, both when the battery is above and
below charge_start_threshold.  Input validation also works
as-expected.  The only oddity I noticed is that force_discharge has a
delay taking effect (<1 sec) transitioning from 0 to 1 (but not 1 to
0).

Tested-by: Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>

Thanks for working on this!
Kevin

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
