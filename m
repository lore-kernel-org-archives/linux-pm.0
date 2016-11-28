From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 00/10] PM / OPP: Multiple regulator support
Date: Mon, 28 Nov 2016 19:11:46 +0530
Message-ID: <CAKohpo=fKG__Tf4LF1YZRKXsw4FdWxnP4NHyAPpKtFKcQ7GmMg@mail.gmail.com>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 24 November 2016 at 17:06, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
>
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the order in which multiple
> supplies need to be programmed, before or after a frequency change. It
> was considered in this patch and such information is left for the
> platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
>
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
>
> Dave Gerlach has already tested [2] it on the real TI platforms and it
> works well for him.
>
> This is rebased over: linux-next branch in the PM tree.
>
> V3->V4:
> - Separate out cpu-supply fix in the binding in a separate patch (Mark).
> - Add more documentation to the binding to explain that the relation to
>   the supplies and the order of programming them is left for the
>   platform specific bindings and that every platform using multiple
>   regulators for their devices needs to provide a separate binding
>   document explaining their implementation (Mark).
> - @Rob and Stephen: I have kept your Acks for the bindings as the
>   bindings only got a bit reworded (improved) since the time you guys
>   Acked them. Please let me know if you want more improvement in the
>   bindings now.
> - V4 for 10/10 was sent earlier, which added a missing
>   rcu_read_unlock(). Nothing else changed in it.
> - Added some missing Kernel documentation comments

Hi Rafael,

The first version of this series was sent on 4th of October and its been
~2 months now that this series is getting reviewed. All of the stuff has
already been seen by Stephen and others.

Mark had some particular concerns in V3, which I discussed with him
over IRC and resolved. The DT bindings are already Acked by Rob
and Stephen otherwise.

Will it be possible to get this merged for 4.10-rc1, as no one has raised
any objections so far? Looks like Stephen is a bit busy at the moment,
and is unable to review stuff for now.

I don't want to get this delayed by another merge cycle. If there are any
shortcomings reported later by others, I can always go fix them very
quickly.

Thanks.

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
