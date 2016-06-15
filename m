From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support using genpd
Date: Wed, 15 Jun 2016 15:29:48 +0200
Message-ID: <CAPDyKFrerQU61iN6qjLLbw_=xmodmkGCZMEx29kC6arOzMfHiw@mail.gmail.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-4-git-send-email-sudeep.holla@arm.com> <CAPDyKFp5GacJNq_hqhrdupN9gYNHYmE_-Z7ZV-c6BP59AaurZw@mail.gmail.com>
 <576156D6.4010606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37641 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbcFON3u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 09:29:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id a66so24961901wme.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 06:29:50 -0700 (PDT)
In-Reply-To: <576156D6.4010606@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[...]

>
>>> +static const struct of_device_id scpi_power_domain_ids[] = {
>>> +       { .compatible = "arm,scpi-power-domains", },
>>> +       { /* sentinel */ }
>>> +};
>>
>>
>> Actually I think you shouldn't implement this a standalone driver and
>> thus you can remove this compatible.
>>
>
> While I tend to agree, I did this to keep it aligned with other SCPI
> users(clocks, sensors,.. for example).
>
> I assume remove compatible just from driver ? IMO, it doesn't make sense
> to add power domain provider without a compatible.
>
>> Instead, I think it's better if you let the arm_scpi driver to also
>> initialize the PM domain.
>>
>
> OK, I can do that.
>
>> If you still want the PM domain code to be maintained in a separate
>> file, just provide a header file which declares an
>> "scpi_pm_domain_init()" function (and a stub when not supported),
>> which the arm_scpi driver should call during ->probe().
>>
>
> I am fine with that, just that it deviates from the approach taken in
> other subsystems as I mentioned above.

If DT maintainers are happy with you adding a compatible for this,
don't let me stop you from implementing this as standalone driver.

I have no strong opinions about it, so perhaps it's then better to not
deviate from other cases!?

Kind regards
Uffe
