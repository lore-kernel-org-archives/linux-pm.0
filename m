From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / Runtime: Add notifiers for device runtime PM
	events
Date: Fri, 17 Jun 2016 08:24:23 +0200
Message-ID: <8bc9aa9f-f42c-3c1b-b949-c2caf2f2a270@samsung.com>
References: <1465381556-2230-1-git-send-email-m.szyprowski@samsung.com>
	<1465381556-2230-2-git-send-email-m.szyprowski@samsung.com>
	<CAJZ5v0g_7Xsmo0U4YU+V3xjEPfCL7R02VgyB524Mu=dwPwt+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAJZ5v0g_7Xsmo0U4YU+V3xjEPfCL7R02VgyB524Mu=dwPwt+Ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,


On 2016-06-08 19:18, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 12:25 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>  wrote:
>> From: Krzysztof Kozlowski<k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> Allow drivers registering for certain runtime PM events of other
>> devices. Some drivers in power domain are more or less coupled. When one
>> driver is suspending (thus leading to power domain being also turned
>> off) the other might have to perform some necessary steps. For example
>> Exynos IOMMU has to save its context.
>>
>> Based on previous work of Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>.
>>
>> Signed-off-by: Krzysztof Kozlowski<k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Marek Szyprowski<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> No, this is not the right way to address this and using notifiers for
> that is just wrong (because of the potential ordering issues).
>
> Also, the problem is not limited to runtime PM, but also to system
> suspend/resume and initialization/shutdown.
>
> I posted a series of device dependencies patches a few months ago that
> might help to address this problem, but there was almost no interest
> in it at that time.

I spent some time digging for your patches. Sadly no list archives had
them all and I finally found them only in the linux-pm patchwork. This
may explain why there was almost no interest in them.

After some debugging I've managed to get it working for my case. I will
include your patches in my v2 patchset together with the fixes needed to
get it working.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
