From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC v11 1/3] PM / Domains: Support for multiple states
Date: Wed, 10 Feb 2016 11:24:02 +0100
Message-ID: <CAPDyKFqZ6zZE7gOpgpEozmfU+Wbh2PcR=rpjsDwUBTTa1M0k4A@mail.gmail.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
	<1455023751-32521-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFpyFj=8RAwXH0H7VM=MVrLbVDwm_1hNngPyV6OyNqrm_g@mail.gmail.com>
	<CAKXjFTMzgy1gp5rG4N8UOKkoUa1qMzzrU2Vy7pNF8+FiNbinUQ@mail.gmail.com>
	<CAPDyKFqg0YkAvS2xZewpF4EOeeaVP9jWQxcwkDB5ofOrONq6+g@mail.gmail.com>
	<CAKXjFTNOO8LG6=Wt8M3rnSZ5NeZSmWk4=j0N3=GgbRm=C98Vmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33052 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbcBJKYD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 05:24:03 -0500
Received: by mail-yw0-f169.google.com with SMTP id u200so10767045ywf.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2016 02:24:02 -0800 (PST)
In-Reply-To: <CAKXjFTNOO8LG6=Wt8M3rnSZ5NeZSmWk4=j0N3=GgbRm=C98Vmw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Jon Hunter <jonathanh@nvidia.com>

+ Jon

>>>> >  struct generic_pm_domain {
>>>> >         struct dev_pm_domain domain;    /* PM domain operations */
>>>> >         struct list_head gpd_list_node; /* Node in the global PM domains
>>>> > list */
>>>> > @@ -66,6 +71,10 @@ struct generic_pm_domain {
>>>> >         void (*detach_dev)(struct generic_pm_domain *domain,
>>>> >                            struct device *dev);
>>>> >         unsigned int flags;             /* Bit field of configs for
>>>> > genpd */
>>>> > +       struct genpd_power_state *states;
>>
>> I suggest we change this to:
>>
>> struct genpd_power_state states[MAX_GENPD_STATES];
>>
>> I don't know what value MAX_GENPD_STATES should have but perhaps 8 is
>> good enough. In that way the number of supported states will be
>> "static". It's not the nicest thing to do, but I can't figure out a
>> better option.
>
> Ok understood, i had a doubt because in my first couple of series i was doing
> that, but there was a suggestion form Geert to rather allocate the
> states to save the unused memory.
> Is it ok if i implement it with  static struct for now to keep this
> series small?

>From my point of view, yes.

>
> Otherwise, i will implement the error code return and checking from
> pm_genpd_init.
>

You may try that, but it will for sure involve a lot more changes.

Perhaps we should postpone that until the pm_genpd_remove() API has
been merged, as it seems somewhat related.
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/404504.html

Kind regards
Uffe
