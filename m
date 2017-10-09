From: Todor Tomov <todor.tomov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit
 control of PM domains
Date: Mon, 9 Oct 2017 19:36:49 +0300
Message-ID: <72397ec8-d169-c5b1-2120-459031b35d48@linaro.org>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <CAJZ5v0gMzN_zfC_2nnRtYFyFon3-_mnioQhNbDP0wsr91RnagA@mail.gmail.com>
 <ffe13074-9113-0a20-0fa6-76d0209dadfc@nvidia.com>
 <1832647.f77WMLkdQb@aspire.rjw.lan>
 <CAPDyKFokVKZfRAsEAB6ihx1FxW4JjarionyOwCATr3s+QW4aMg@mail.gmail.com>
 <b4e8fd34-e2f0-165d-aa22-32ba43a8dbed@nvidia.com>
 <CAPDyKFo-hfwbrY+AEMt0=fMshiT-BWvYDvGkKGqquTdowUvWHw@mail.gmail.com>
 <107242f1-de90-b8bb-bc2c-feaf014485aa@nvidia.com>
 <CAPDyKFqeAWoy-vfN89j8Yv1HTMpNqwcVk3XrTQoXH5JNrQ9Maw@mail.gmail.com>
 <b1c74af3-1943-51ff-0bc9-009ca6c7f217@nvidia.com>
 <5fcfeda6-f95c-cdaa-73a5-5c7499a3f9f5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5fcfeda6-f95c-cdaa-73a5-5c7499a3f9f5-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 30.05.2017 06:41, Rajendra Nayak wrote:
> []..
> 
>>>> I was proposing to have such a lower-layer by splitting the existing
>>>> genpd framework so the drivers would have the option of calling the
>>>> lower-level power control functions to look-up pm-domains and control
>>>> them directly from their rpm callbacks (if they need to). Same as we do
>>>> for clocks. This way you would not need to mess with the genpd ->start()
>>>> callback and leave it to the driver to handle itself as it knows what
>>>> needs to be done. This assumes that the device is never bound to the
>>>> pm-domain by the genpd core.
>>>
>>> Yes, agree! To me this is the only solution what would really work.
>>
>> I agree! :-)
>>
>>> Perhaps Rafael can confirm that he is fine with a solution like this?
>>
>> Yes and Rafael, please can you also elaborate on what you meant by
>> "allow genpd to use either a list of power resources or the on/off
>> callbacks provided by itself to cover different use cases"?
>>
>> I would like to understand exactly what you meant by allowing genpd to
>> use a list of power resources (ie. how you envisioned we could achieve
>> this).
> 
> While thinking through the problem of devices associated with multiple Power
> domains (or power resources) and controlling them individually (or together)
> I was wondering if something like a PM domain governor (with PM resource 
> level constraints) could help.
> 
> So with just one set of PM domain callbacks, its quite easy to control multiple power
> resources, if they need to be *all* turned on/off together, using something similar to
> what Jon proposed in his RFC [1]
> 
> However, there could be instances where in we might need to control them individually
> and in such cases we could hook up a PM domain governor which decides if an individual
> PM resource can be turned on or off while the device is runtime suspended/resumed.
> We can expose some PM resource level QoS APIs which the drivers can use to express their
> needs, which the PM domain governor then takes into account during the decision making.
> 
> if this seems worth pursuing further, I can post some RFCs on these lines and
> get the discussion going.
> 
> thanks,
> Rajendra
> 
> [1] https://lkml.org/lkml/2016/9/20/173
> 

I have come to a similar case with multiple power domains on Qualcomm APQ8096 - the
camera subsystem has two VFE modules (Video Front End - these are image processing modules)
and each of them has a separate power domain but we might want to control these from
a single driver.

So I wanted to ask if there have been any news on this topic lately?

Thank you.
Best regards,
Todor
