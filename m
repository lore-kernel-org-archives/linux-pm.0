From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 00/10] PM / OPP: Multiple regulator support
Date: Tue, 6 Dec 2016 02:34:35 +0100
Message-ID: <CAJZ5v0gykH+UwMvgU3SCVgxg9Ufe23zQ1o9bEvnjtafVqjLa8Q@mail.gmail.com>
References: <cover.1480564564.git.viresh.kumar@linaro.org> <CAKohpokXXhcrhzqs+iW+1kTYjyF47bHF0TupMxP=4cSqXOThtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpokXXhcrhzqs+iW+1kTYjyF47bHF0TupMxP=4cSqXOThtA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 5, 2016 at 3:21 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 1 December 2016 at 16:28, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Hi,
>>
>> Some platforms (like TI) have complex DVFS configuration for CPU
>> devices, where multiple regulators are required to be configured to
>> change DVFS state of the device. This was explained well by Nishanth
>> earlier [1].
>>
>> One of the major complaints around multiple regulators case was that the
>> DT isn't responsible in any way to represent the order in which multiple
>> supplies need to be programmed, before or after a frequency change. It
>> was considered in this patch and such information is left for the
>> platform specific OPP driver now, which can register its own
>> opp_set_rate() callback with the OPP core and the OPP core will then
>> call it during DVFS.
>>
>> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
>> and code to pass values for multiple regulators and verified that they
>> are all properly read by the kernel (using debugfs interface).
>>
>> Dave Gerlach has already tested [2] it on the real TI platforms and it
>> works well for him.
>>
>> This is rebased over: linux-next branch in the PM tree.
>>
>> V6->V7:
>> - Added RBY from Stephen for the 8th patch as well.
>> - Rebased over pm/bleeding-edge as the dependency patch is already
>>   applied there.
>> - s/dev_pm_opp_set_regulator()/dev_pm_opp_set_regulators() in a comment.
>> - Removed the local 'names' array in cpufreq-dt and used "&name"
>>   instead.
>> - Only the 6th patch doesn't have a Reviewed-by Tag now..
>
> Hi Rafael,
>
> V6 of this series received some minor comments [1] and I have
> resolved them all here. Now that the merge window is so close,
> I think we should be merge it now so that it gets a chance to live
> in linux-next for few days.

I've queued them up, but I'd feel more comfortable with an ACK or
Reviewed-by on patch [6/10] too.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
