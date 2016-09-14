From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] iommu/exynos: Add proper runtime pm support
Date: Wed, 14 Sep 2016 13:54:50 +0200
Message-ID: <CAPDyKFo=2+9cVN-9N1w8z_+dpopgccceA=x0cimxNG9w4xZX0g@mail.gmail.com>
References: <CGME20160913124918eucas1p29f49efbb142d416215482c29b53daff8@eucas1p2.samsung.com>
 <1473770941-8337-1-git-send-email-m.szyprowski@samsung.com>
 <1473770941-8337-3-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFo5D3kGRt=4mBH9-XpLU6eOm4jah1xjyR3disFiJfXjoA@mail.gmail.com>
 <ca6b2547-dc67-bb3c-e5af-7f5eeddfd54d@samsung.com> <CAPDyKFqtBhA6kv-DFmeCiWbn0q0g2hFR5-+9M7CgvbzNH2iOzQ@mail.gmail.com>
 <6f5e9bd4-10f6-e9cb-3e2a-ef6ff8a38bc5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38209 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760440AbcINLyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 07:54:53 -0400
Received: by mail-wm0-f53.google.com with SMTP id 1so25938924wmz.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Sep 2016 04:54:52 -0700 (PDT)
In-Reply-To: <6f5e9bd4-10f6-e9cb-3e2a-ef6ff8a38bc5@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>

[...]

>>>
>>>> To solve this problem, I was thinking we could convert to use the
>>>> asynchronous pm_runtime_get() API, when trying to runtime resume the
>>>> device from atomic contexts.
>>>
>>> I'm not sure if this will work for DMA engine devices. If I understand
>>> correctly some client's of DMA engine device might rely on the DMA
>>> engine being configured and operational after queuing a request and
>>> they might lock up if the DMA engine device activation if postponed
>>> because of async runtime pm activation.
>>
>> I didn't know about this. If you have an example from the top of your
>> head, could you perhaps point me to it?
>
>
> No, I don't have any example. This is just my fear that there might be some
> hardware which works this way. I can imagine a driver, which queue dma
> engine
> request and then triggers 'start' command to its hw block. HW blocks usually
> uses some additional signal lines for DMA, so the HW block might check if
> all
> needed signals from DMA engine HW are ready. If not it will fail to start
> avoid lockup of starting without DMA engine HW being ready.

Well, I think this reasoning makes lots of sense! Clearly we wouldn't
be able to guarantee that there's isn't a glitch in an undefined HW
behaviour.

I will drop my suggested approach and try out another one.

>
> However I don't have much experience with DMA engine and drivers. I only
> helped in adding DMA engine support to Samsung UART driver and in the
> hardware manual there is information about additional lines between DMA
> controller and UART module, which are used in the DMA mode.

Thanks for sharing your experience!

Now, I should allow you to get back to the original review! :-)

Kind regards
Uffe
