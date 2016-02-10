From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC v11 1/3] PM / Domains: Support for multiple states
Date: Wed, 10 Feb 2016 09:08:28 +0100
Message-ID: <CAPDyKFqg0YkAvS2xZewpF4EOeeaVP9jWQxcwkDB5ofOrONq6+g@mail.gmail.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
	<1455023751-32521-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFpyFj=8RAwXH0H7VM=MVrLbVDwm_1hNngPyV6OyNqrm_g@mail.gmail.com>
	<CAKXjFTMzgy1gp5rG4N8UOKkoUa1qMzzrU2Vy7pNF8+FiNbinUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35993 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbcBJII3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 03:08:29 -0500
Received: by mail-yk0-f175.google.com with SMTP id z7so4729460yka.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2016 00:08:29 -0800 (PST)
In-Reply-To: <CAKXjFTMzgy1gp5rG4N8UOKkoUa1qMzzrU2Vy7pNF8+FiNbinUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

[...]

Hi Axel,

Please make sure to send emails in plain text.

>> > +static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>> > +{
>> > +       int ret;
>> > +
>> > +       if (IS_ERR_OR_NULL(genpd)) {
>> > +               ret = -EINVAL;
>> > +               goto err;
>> > +       }
>>
>> No need for this check. It's a static function called by
>> pm_genpd_init(), which already done this.
>>
>> > +
>> > +       genpd->states = kcalloc(1, sizeof(struct genpd_power_state),
>> > +                               GFP_KERNEL);
>> > +       if (!genpd->states) {
>> > +               ret = -ENOMEM;
>> > +               goto err;
>>
>> I just realized that this won't play well, mainly because
>> pm_genpd_init() don't return any error codes.
>>
>> I suggest to not allocate the data for "states" on the heap, but
>> instead use a static struct.
>>
>> That means the function should be "static void" and perhaps renamed to
>> genpd_set_default_state() or similar.
>
>
>
>
> I have one doubt here, if i use static struct instead of allocating it,
> would it not mean that all genpd's that use this function would share
> the same state struct?
>
> the latency values are potentially updated when using the power on/off
> functions,
> so i think they should have they own separate "per-genpd" state struct.

Right! Apologize for my vague answer.

See more below.

[...]

>
>> >
>> > +struct genpd_power_state {
>> > +       s64 power_off_latency_ns;
>> > +       s64 power_on_latency_ns;
>> > +};
>> > +
>> >  struct generic_pm_domain {
>> >         struct dev_pm_domain domain;    /* PM domain operations */
>> >         struct list_head gpd_list_node; /* Node in the global PM domains
>> > list */
>> > @@ -66,6 +71,10 @@ struct generic_pm_domain {
>> >         void (*detach_dev)(struct generic_pm_domain *domain,
>> >                            struct device *dev);
>> >         unsigned int flags;             /* Bit field of configs for
>> > genpd */
>> > +       struct genpd_power_state *states;

I suggest we change this to:

struct genpd_power_state states[MAX_GENPD_STATES];

I don't know what value MAX_GENPD_STATES should have but perhaps 8 is
good enough. In that way the number of supported states will be
"static". It's not the nicest thing to do, but I can't figure out a
better option.

Another option would be to change the pm_genpd_init() API to return an
int as it needs to be able to propagate an error code, if it allocates
data dynamically.

>> > +       unsigned int state_count; /* number of states */
>> > +       unsigned int state_idx; /* state that genpd will go to when off
>> > */
>> > +

[...]

Kind regards
Uffe
