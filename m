From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Tue, 28 Feb 2017 16:14:06 +0100
Message-ID: <CAPDyKFo5TjTa-hTzNp5KCpozU87L22piCXaSjWMTr4xVkgP+Pg@mail.gmail.com>
References: <cover.1487926924.git.viresh.kumar@linaro.org> <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org>
 <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop> <20170228065711.GD19417@vireshk-i7>
 <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>                                     ---> Parent domain-2 (Contains Perfomance states)
>>                                     |
>>                                     |
>> C.) DeviceX  --->  Parent-domain-1  |
>>                                     |
>>                                     |
>>                                     ---> Parent domain-3 (Contains Perfomance states)
>
> I'm a bit confused. How does a domain have 2 parent domains?

This comes from the early design of the generic PM domain, thus I
assume we have some HW with such complex PM topology. However, I don't
know if it is actually being used.

Moreover, the corresponding DT bindings for "power-domains" parents,
can easily be extended to cover more than one parent. See more in
Documentation/devicetree/bindings/power/power_domain.txt

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
