From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2] power: reset: Add Spreadtrum SC27xx PMIC power off support
Date: Wed, 14 Feb 2018 10:14:46 +0800
Message-ID: <CAMz4ku+z6PBKQWfadhpi2yGeeM+=ZnPVAbdKc5+3XyvUvAZzAQ@mail.gmail.com>
References: <7655f39d44e804c9ed3209db475567abc250f642.1518169282.git.baolin.wang@linaro.org>
 <20180209123044.vjvkb3yfmk4gqfiv@earth.universe> <20180213124810.oyf4ec5bpbnsnkqy@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38352 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966431AbeBNCOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Feb 2018 21:14:47 -0500
Received: by mail-ot0-f195.google.com with SMTP id h14so19100135otj.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2018 18:14:47 -0800 (PST)
In-Reply-To: <20180213124810.oyf4ec5bpbnsnkqy@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Sebastian,

On 13 February 2018 at 20:48, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Baolin,
>
> On Fri, Feb 09, 2018 at 01:30:44PM +0100, Sebastian Reichel wrote:
>> On Fri, Feb 09, 2018 at 05:43:38PM +0800, Baolin Wang wrote:
>> > On Spreadtrum platform, we need power off system through external SC27xx
>> > series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chips.
>> > Thus this patch adds SC27xx series PMICs power-off support.
>> >
>> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> Thanks, queued. My public -next branch is waiting for 4.16-rc1,
>> though.
>
> I just dropped this patch. It does not compile as a module:
>
> ERROR: "freeze_secondary_cpus" [drivers/power/reset/sc27xx-poweroff.ko] undefined!
>
> There is no EXPORT_SYMBOL for freeze_secondary_cpus, so you either
> need to add that or make the new driver built-in only.

I am sorry for the building error, and I will  make the driver
built-in only in next version. Thanks.

-- 
Baolin.wang
Best Regards
