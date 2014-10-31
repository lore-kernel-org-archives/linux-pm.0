From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe option
Date: Fri, 31 Oct 2014 10:29:36 +0100
Message-ID: <CAPDyKFpz2Finv0BUmp1pQtihUzUULCfj7hmOJW3CJ_cWErLySQ@mail.gmail.com>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
	<1413795888-18559-2-git-send-email-k.kozlowski@samsung.com>
	<1414746895.6797.3.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:48084 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbaJaJ3g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Oct 2014 05:29:36 -0400
Received: by mail-qg0-f49.google.com with SMTP id z60so2506593qgd.36
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2014 02:29:36 -0700 (PDT)
In-Reply-To: <1414746895.6797.3.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 31 October 2014 10:14, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
>> Add a simple getter pm_runtime_is_irq_safe() for querying whether runtime
>> PM IRQ safe was set or not.
>>
>> Various bus drivers implementing runtime PM may use choose to suspend
>> differently based on IRQ safeness status of child driver (e.g. do not
>> unprepare the clock if IRQ safe is not set).
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, Len, Pavel,
>
> Is proposed API ok? Do you have any comments?
>
> I'll upload whole patchset to Russell's patch tracking system. However
> an ack from PM maintainer is probably needed.

I would actually prefer the opposite. It's better if we can take these
patches through Rafaels tree.

1) I have posted patches for the amba bus, these may have merge
conflicts with your changes.
2) We may start using the new runtime PM API within genpd as of now.

Kind regards
Uffe
