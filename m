From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] iommu/exynos: Add proper runtime pm support
Date: Mon, 10 Oct 2016 15:32:06 +0200
Message-ID: <87aeb58b-bda0-93c5-e51d-ab9be0b9d518@samsung.com>
References: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20160929081240eucas1p231c1ab5c5936886cbec6bc3f5267c940@eucas1p2.samsung.com>
	<1475136751-31340-3-git-send-email-m.szyprowski@samsung.com>
	<20161006173756.GK3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20161006173756.GK3296-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Luis


On 2016-10-06 19:37, Luis R. Rodriguez wrote:
> On Thu, Sep 29, 2016 at 10:12:31AM +0200, Marek Szyprowski wrote:
>> This patch uses recently introduced device links to track the runtime pm
>> state of the master's device. This way each SYSMMU controller is runtime
>> activated when its master's device is active
> instead of?

instead of keeping SYSMMU controller runtime active all the time.

> BTW what is the master device of a SYSMMU? I have no clue about these
> IOMMU devices here.

Here is a more detailed description of IOMMU hardware I wrote a few days ago
for Ulf:
http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1231006.html

In short: there is a SYSMMU controller and its master device - a device,
which performs DMA operations. That SYSMMU sits in between system memory
and the master device, so it performs mapping of DMA addresses to physical
memory addresses on each DMA operation.

>
>> and can save/restore its state instead of being enabled all the time.
> I take it this means currently even if the master device is disabled
> (whatever that is) all SYSMMU controllers are kept enabled, is that right?
> The issue here is this wastes power? Or what is the issue?

Yes, the issue here is the fact that SYSMMU is kept active all the time,
what in turn prevent the power domain for turning off even if master device
doesn't do anything and is already suspended. This directly (some clocks
enabled) and in-directly (leakage current) causes power looses.

>
>> This way SYSMMU controllers no
>> longer prevents respective power domains to be turned off when master's
>> device is not used.
> So when the master device is idle we want to also remove power from the
> controllers ? How much power does this save on a typical device in the
> market BTW ?

The main purpose of this patchset is to let power domains to be turned off,
because with the current code all domains are all the time turned on, 
because
SYSMMU controllers prevent them from turning them off.

If you want I can measure the power consumption of the idle board with all
domains enabled and disabled if you want to see the numbers. On the 
other board
disabling most power domains in idle state (the clocks were already 
disabled)
gave me about 20mA savings (at 3.7V), what is a significant value for the
battery powered device.

>
>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/iommu/exynos-iommu.c | 225 ++++++++++++++++++-------------------------
>>   1 file changed, 94 insertions(+), 131 deletions(-)
> I'm reviewing the device link patches now but since this is a demo of
> use of that I'll note the changes here are pretty large and it makes
> it terribly difficult for review. Is there any way this patch can be split
> up in to logical atomic pieces that only do one task upon change ?

I will try to split it a bit, but I cannot promise that much can be done
to improve readability for someone not very familiar with the driver
internals.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
