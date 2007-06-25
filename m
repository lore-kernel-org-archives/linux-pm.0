From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/RFT][PATCH -mm 3/4] PM: Rename struct pm_ops
	and related things
Date: Sun, 24 Jun 2007 21:12:49 -0700
Message-ID: <200706242112.50814.david-b__49531.1193670661$1182744824$gmane$org@pacbell.net>
References: <200706242239.05678.rjw@sisk.pl> <200706242242.47573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242242.47573.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 24 June 2007, Rafael J. Wysocki wrote:

>  arch/arm/common/sharpsl_pm.c             |    8 +++----
>  arch/arm/mach-at91/pm.c                  |    4 +--
>  arch/arm/mach-omap1/pm.c                 |    6 ++---
>  arch/arm/mach-omap2/pm.c                 |    6 ++---
>  arch/arm/mach-pnx4008/pm.c               |    4 +--
>  arch/arm/mach-pxa/pm.c                   |    6 ++---
>  arch/arm/mach-sa1100/pm.c                |    6 ++---
>  arch/arm/plat-s3c24xx/pm.c               |    6 ++---
>  arch/blackfin/mach-common/pm.c           |    4 +--
>  arch/powerpc/platforms/52xx/mpc52xx_pm.c |    4 +--
>  arch/sh/boards/hp6xx/pm.c                |    6 ++---
>  drivers/acpi/sleep/main.c                |    6 ++---

It's interesting that so few systems support suspend states,
and thus need to change for this patch ... 


- Dave
