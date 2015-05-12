From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Tue, 12 May 2015 18:26:35 +0200
Message-ID: <CAKXjFTNYDoU0b==wgNwX8KRx5gtnzHYn_ET66=oTdHE7SabKXQ@mail.gmail.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
	<1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
	<20150512153702.GL16124@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33126 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbELQ0g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 12:26:36 -0400
Received: by obblk2 with SMTP id lk2so9791249obb.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 09:26:36 -0700 (PDT)
In-Reply-To: <20150512153702.GL16124@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Lina,

On Tue, May 12, 2015 at 5:37 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>>
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> prepare generic power domain init function parameters
>> to accept a pointer to the states structure that describes
>> the possible states that a power domain can enter.
>>
>> There is no functional change, as support for multiple
>> domains will be added in subsequent patches.
>>
>> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>
>
> [...]
>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 681ccb0..6b4802e 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -46,6 +46,12 @@ struct gpd_cpuidle_data {
>>         struct cpuidle_state *idle_state;
>> };
>>
>> +struct genpd_power_state {
>> +       char *name;
>> +       s64 power_off_latency_ns;
>> +       s64 power_on_latency_ns;
>> +};
>> +
>
>
> I know you carried this over from the existing code, but any reason why
> this should be signed?
>

correct, i just carried this values over as they were originally.
i suppose they can be changed to u64.

maybe a separate cleanup patch,  as it would make sense to change
some other s64's in domain.c, like "s64 elapsed_ns;"




> -- Lina
