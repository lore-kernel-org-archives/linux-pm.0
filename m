From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] pm: Add PM domain notifications
Date: Thu, 11 Dec 2014 16:30:23 +0100
Message-ID: <CAPDyKFpjPdj=uy-xAN7iMivDJFPYA-ykkkjEeyHh+6KFv4ktTg@mail.gmail.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
	<1418286387-9663-2-git-send-email-tfiga@chromium.org>
	<548973B7.3050107@samsung.com>
	<CAAFQd5DrzYRCF3tW7cg=rZ3wB1G2kQtWbCx+Pby9obNTewsFdg@mail.gmail.com>
	<5489A227.8010907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5489A227.8010907-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Beata Michalska <b.michalska-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Amit Kachhap <amit.kachhap-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11 December 2014 at 14:54, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 11/12/14 12:04, Tomasz Figa wrote:
> ...
>>> > On 11/12/14 09:26, Tomasz Figa wrote:
>>>> > > From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>> > >
>>>> > > This patch adds notifiers to the runtime PM/genpd subsystem. It is now
>>>> > > possible to register a notifier, which will be called before and after
>>>> > > the generic power domain subsystem calls the power domain's power_on
>>>> > > and power_off callbacks.
>>>> > >
>>>> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>> > > [tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org: rebased]
>>>> > > Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> >
>>> > Not sure if you've noticed it, I posted an updated version of this patch
>>> > recently [1]. The notifiers list is moved to struct generic_pm_domain
>>> > there and it also allows to register a notifier for selected power domain
>>> > by name.
>> [snip]
>>> > [1] http://www.spinics.net/lists/linux-samsung-soc/msg38549.html
>>
>> Ah, haven't noticed, sorry. The API using devices looks the same, so I
>> guess we can simply have patch 2/2 of this series applied on top of
>> your patch.
>
> Yes, that should work.
>
>> By the way, look-up by name (presumably hardcoded somewhere?) sounds a
>> bit strange to me. What was the reason for it to be added?
>
> Yes, that might not be a very elegant approach. We initially used it
> to implement power domain on/off sequence per specific domain and SoC,
> since it appeared resistant to generalize.  I.e. the control register
> write sequences are different per domain and per SoC (exynos).
> So we named the domains in the device tree in that way:
>
>         pm_domains: pm-domains@10024000 {
>                 compatible = "samsung,exynos4415-pd";
>                 reg-names = "cam", "tv", "mfc", "g3d",
>                             "lcd0", "isp0", "isp1";
>                 reg = <0x10024000 0x20>, <0x10024020 0x20>,
>                       <0x10024040 0x20>, <0x10024060 0x20>,
>                       <0x10024080 0x20>, <0x100240A0 0x20>,
>                       <0x100240E0 0x20>;
>                 #power-domain-cells = <1>;
>         };
>
> and then, for example, in the exynos CMU_ISP{0, 1} (clock controller)
> driver registered for notification on "isp0" and "isp1" power domains
> ("isp1" is a sub-domain of "isp0" and the consumer devices are normally
> attached to "isp1").
>
> We have been investigating if we could do without the notification
> at the clocks driver side, then the all SoC/power domain specific code
> would end up in the exynos power domain driver. But I'm afraid it's
> not going to work for all SoCs. Anyway lookup by name might be not
> needed.

Regarding "lookup by name", let's please move away from those APIs. I
am planning to remove all name based API from the genpd API as soon as
I can.

If you need to fetch domains, this might help you:
http://www.spinics.net/lists/arm-kernel/msg383743.html

Kind regards
Uffe
