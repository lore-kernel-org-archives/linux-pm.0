From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()
Date: Wed, 27 Apr 2016 11:10:04 -0700
Message-ID: <7hoa8uj537.fsf@baylibre.com>
References: <1461312955-8547-1-git-send-email-ulf.hansson@linaro.org>
	<1461312955-8547-2-git-send-email-ulf.hansson@linaro.org>
	<7h37qdxz5t.fsf@baylibre.com>
	<CAPDyKFqtQhbaDw4_k7xc=mMHBda1fn55t7_9w+PKYQHzSdcTpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32935 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbcD0SKG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 14:10:06 -0400
Received: by mail-pa0-f54.google.com with SMTP id zm5so24568235pac.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 11:10:05 -0700 (PDT)
In-Reply-To: <CAPDyKFqtQhbaDw4_k7xc=mMHBda1fn55t7_9w+PKYQHzSdcTpw@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 25 Apr 2016 10:21:34 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 22 April 2016 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> The PM core increases the runtime PM usage count in the system PM prepare
>>> phase.
>>
>> nit: increases/decreases ... prepare/complete
>>
>>> This makes some of the pm_runtime_get|put*() calls in
>>> pm_gendp_prepare() redundant, so let's remove them.
>>
>> s/gendp/genpd/
>>
>> And also add pm_genpd_complete()
>
> As a matter fact that isn't the case. There's no pm_runtime_put*() in
> pm_genpd_complete().
>
> Although, perhaps you were thinking about enabling/disabling of
> runtime PM, as that is being done in pm_genpd_prepare() and
> pm_genpd_complete(). I intend to change as well, but in a separate
> patch.

Actually, I was thinking of device_complete() where there is the _put()

>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Otherwise...
>>
>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>>
>
> Thanks for reviewing, I will update the change log accordingly!

Thanks,

Kevin
