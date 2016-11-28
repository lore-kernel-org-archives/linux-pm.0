From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 00/10] PM / OPP: Multiple regulator support
Date: Mon, 28 Nov 2016 14:45:47 +0100
Message-ID: <CAJZ5v0hLm0eAvo-_M4Ossrsn96VZ99ZNhT+ETCzB=s+ekCpGEg@mail.gmail.com>
References: <cover.1479986491.git.viresh.kumar@linaro.org> <CAKohpo=fKG__Tf4LF1YZRKXsw4FdWxnP4NHyAPpKtFKcQ7GmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpo=fKG__Tf4LF1YZRKXsw4FdWxnP4NHyAPpKtFKcQ7GmMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 28, 2016 at 2:41 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 24 November 2016 at 17:06, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Hi,
>>

[cut]

> Hi Rafael,
>
> The first version of this series was sent on 4th of October and its been
> ~2 months now that this series is getting reviewed. All of the stuff has
> already been seen by Stephen and others.
>
> Mark had some particular concerns in V3, which I discussed with him
> over IRC and resolved. The DT bindings are already Acked by Rob
> and Stephen otherwise.
>
> Will it be possible to get this merged for 4.10-rc1, as no one has raised
> any objections so far? Looks like Stephen is a bit busy at the moment,
> and is unable to review stuff for now.
>
> I don't want to get this delayed by another merge cycle. If there are any
> shortcomings reported later by others, I can always go fix them very
> quickly.

OK, let's see how this goes.

I guess I'll apply https://patchwork.kernel.org/patch/9446545/ too, then.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
