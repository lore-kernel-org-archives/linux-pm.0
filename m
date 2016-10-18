From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 0/5] Functional dependencies between devices
Date: Tue, 18 Oct 2016 12:46:30 +0200
Message-ID: <ef96a88b-240e-17b1-904d-b7a778a999ec@samsung.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CGME20161010125153eucas1p2b86325c046d3e0d0b6275abd000ea096@eucas1p2.samsung.com>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56853 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbcJRKqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 06:46:37 -0400
In-reply-to: <13957403.ZrB4mMbICz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

Hi Rafael,


On 2016-10-10 14:36, Rafael J. Wysocki wrote:
> [...]
>
> One more update after some conversations during LinuxCon Europe.
>
> The main point was to make it possible for device_link_add() to figure out the
> initial state of the link instead of expecting the caller to provide it which
> might not be reliable enough in general.
>
> In this version device_link_add() takes three arguments, the supplier and
> consumer pointers and flags and it sets the correct initial state of the link
> automatically (unless invoked with the "stateless" flag, of course).  The cost
> is one additional field in struct device (I moved all of the links-related
> fields in struct device to a separate sub-structure while at it) to track
> the "driver presence status" of the device (to be used by device_link_add()).
>
> In addition to that, the links list walks in the core.c and dd.c code are
> under the device links mutex now, so the iternal link spinlock is not needed
> any more and I have renamed symbols to distinguish between flags, link states
> and device "driver presence statuses".
>
> More information is there in the changelogs.

Thanks for the update. This version is indeed easier to use and still 
works fine
with my Exynos IOMMU runtime pm rework. You can keep my:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I will send updated version of my patchset soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

