From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v11 1/3] PM / Domains: Support for multiple states
Date: Wed, 10 Feb 2016 10:25:30 +0100
Message-ID: <CAKXjFTNOO8LG6=Wt8M3rnSZ5NeZSmWk4=j0N3=GgbRm=C98Vmw@mail.gmail.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
	<1455023751-32521-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFpyFj=8RAwXH0H7VM=MVrLbVDwm_1hNngPyV6OyNqrm_g@mail.gmail.com>
	<CAKXjFTMzgy1gp5rG4N8UOKkoUa1qMzzrU2Vy7pNF8+FiNbinUQ@mail.gmail.com>
	<CAPDyKFqg0YkAvS2xZewpF4EOeeaVP9jWQxcwkDB5ofOrONq6+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35422 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbcBJJZb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 04:25:31 -0500
Received: by mail-ob0-f176.google.com with SMTP id xk3so19020917obc.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2016 01:25:31 -0800 (PST)
In-Reply-To: <CAPDyKFqg0YkAvS2xZewpF4EOeeaVP9jWQxcwkDB5ofOrONq6+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Feb 10, 2016 at 9:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
> Hi Axel,
>
> Please make sure to send emails in plain text.

Yes, Sorry about that.

>
>>> > +static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>>> > +{
>>> > +       int ret;
>>> > +
>>> > +       if (IS_ERR_OR_NULL(genpd)) {
>>> > +               ret = -EINVAL;
>>> > +               goto err;
>>> > +       }
>>>
>>> No need for this check. It's a static function called by
>>> pm_genpd_init(), which already done this.
>>>
>>> > +
>>> > +       genpd->states = kcalloc(1, sizeof(struct genpd_power_state),
>>> > +                               GFP_KERNEL);
>>> > +       if (!genpd->states) {
>>> > +               ret = -ENOMEM;
>>> > +               goto err;
>>>
>>> I just realized that this won't play well, mainly because
>>> pm_genpd_init() don't return any error codes.
>>>
>>> I suggest to not allocate the data for "states" on the heap, but
>>> instead use a static struct.
>>>
>>> That means the function should be "static void" and perhaps renamed to
>>> genpd_set_default_state() or similar.
>>
>>
>>
>>
>> I have one doubt here, if i use static struct instead of allocating it,
>> would it not mean that all genpd's that use this function would share
>> the same state struct?
>>
>> the latency values are potentially updated when using the power on/off
>> functions,
>> so i think they should have they own separate "per-genpd" state struct.
>
> Right! Apologize for my vague answer.
>
> See more below.
>
> [...]
>
>>
>>> >
>>> > +struct genpd_power_state {
>>> > +       s64 power_off_latency_ns;
>>> > +       s64 power_on_latency_ns;
>>> > +};
>>> > +
>>> >  struct generic_pm_domain {
>>> >         struct dev_pm_domain domain;    /* PM domain operations */
>>> >         struct list_head gpd_list_node; /* Node in the global PM domains
>>> > list */
>>> > @@ -66,6 +71,10 @@ struct generic_pm_domain {
>>> >         void (*detach_dev)(struct generic_pm_domain *domain,
>>> >                            struct device *dev);
>>> >         unsigned int flags;             /* Bit field of configs for
>>> > genpd */
>>> > +       struct genpd_power_state *states;
>
> I suggest we change this to:
>
> struct genpd_power_state states[MAX_GENPD_STATES];
>
> I don't know what value MAX_GENPD_STATES should have but perhaps 8 is
> good enough. In that way the number of supported states will be
> "static". It's not the nicest thing to do, but I can't figure out a
> better option.

Ok understood, i had a doubt because in my first couple of series i was doing
that, but there was a suggestion form Geert to rather allocate the
states to save the unused memory.
Is it ok if i implement it with  static struct for now to keep this
series small?

Otherwise, i will implement the error code return and checking from
pm_genpd_init.

>
> Another option would be to change the pm_genpd_init() API to return an
> int as it needs to be able to propagate an error code, if it allocates
> data dynamically.
>
>>> > +       unsigned int state_count; /* number of states */
>>> > +       unsigned int state_idx; /* state that genpd will go to when off
>>> > */
>>> > +
>
> [...]
>
> Kind regards
> Uffe
