From: Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Wed, 27 Jan 2016 11:20:00 -0800
Message-ID: <CANMBJr4_Ee5khJJocJ90D3fgrARWrpm1f1KHkOOjGkf-7XWcLw@mail.gmail.com>
References: <1453362746-9310-1-git-send-email-tomeu.vizoso@collabora.com>
	<20160121105411.GA32212@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160121105411.GA32212@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

On 21 January 2016 at 02:54, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 21, 2016 at 08:52:26AM +0100, Tomeu Vizoso wrote:
>> As per the documentation of the devfreq_dev_profile.target callback, set
>> the freq argument to the new frequency before returning.
>>
>> This caused endless messages like this after recent changes in the core:
>>
>> devfreq 6000c800.actmon: Couldn't update frequency transition information.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> Reported-by: Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 848b93ee930f..fe9dce0245bf 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -500,6 +500,8 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>       clk_set_min_rate(tegra->emc_clock, rate);
>>       clk_set_rate(tegra->emc_clock, 0);
>>
>> +     *freq = rate;
>> +
>>       return 0;
>>  }
>>
>
> I had noticed it recently but hadn't got around to look into it, thanks
> for fixing it.
>
> Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I don't see this patch in -next yet, so I'm guess it hasn't been
applied. Any chance you could pick it up? This issue is now
manifesting in mainline, and causing ton of noise in the boot reports.

Cheers,

Tyler
