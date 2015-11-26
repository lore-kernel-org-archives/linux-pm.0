From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 01/15] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Thu, 26 Nov 2015 23:00:28 +0900
Message-ID: <CAJ0PZbSJ26q9MWSXihQjZih0hSU=w+dR2HKxa67kJhmZtt1tJQ@mail.gmail.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com> <1448545659-32287-2-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448545659-32287-2-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SoC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 26, 2015 at 10:47 PM, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch adds the generic exynos bus frequency driver for AMBA AXI bus
> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exynos SoC
> have the common architecture for bus between DRAM and sub-blocks in SoC.
> This driver can support the generic bus frequency driver for Exynos SoCs.
>
> In devicetree, Each bus block has a bus clock, regulator, operation-point
> and devfreq-event devices which measure the utilization of each bus block.
>
> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/devfreq/Kconfig             |  15 ++
>  drivers/devfreq/Makefile            |   1 +
>  drivers/devfreq/exynos/Makefile     |   1 +
>  drivers/devfreq/exynos/exynos-bus.c | 443 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 460 insertions(+)
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>

Are we finally getting a common Exynos bus driver with full DT support?
(can this replace both Exynos4/5 drivers and support Exynos7 series?)


Cheers,
MyungJoo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
