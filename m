From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [RFC v2 1/3] PM / QoS: Add PM_QOS_MEMORY_BANDWIDTH class
Date: Tue, 19 Aug 2014 09:20:20 +0200
Message-ID: <CAAObsKCLvOJW-Ua5sFgjxWsENr0UsWe1VA5A3QZtCHMwqAPHmQ@mail.gmail.com>
References: <1408107129-29516-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408107129-29516-2-git-send-email-tomeu.vizoso@collabora.com> <20140816063517.GB13884@Nokia-N900>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140816063517.GB13884@Nokia-N900>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Terje Bergstr?m <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 16 August 2014 08:35, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> @@ -13,6 +14,7 @@ Each parameters have defined units:
>>   * latency: usec
>>   * timeout: usec
>>   * throughput: kbs (kilo bit / sec)
>> + * memory bandwidth: kbs (kilo bit / sec)
>
> Would mega bits per second make sense here?
>
> I suppose some many-core systems would have memory bandwith
> in > 10 terabit/sec, overflowing u32.

Yeah, I was a bit concerned about excessive rounding increasing the
chances of going to a higher frequency step than strictly necessary,
but after thinking a bit more about it, I think it won't be a problem
because it would be a bad idea anyway to only take into account
explicit bandwidth requirements when calculating the optimal memory
bus frequency.

So I agree that a coarser unit such as mbps should be more appropriate here.

> Plus, if driver in 3/3 is just an example, perhaps comment
> should explain that clearly?

Will do.

> Otherwise looks good,
>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks,

Tomeu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
