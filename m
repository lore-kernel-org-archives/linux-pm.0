Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE77C10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5C214C6
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1N5ibS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDYKPI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:15:08 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36858 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfDYKPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2019 06:15:08 -0400
Received: by mail-vk1-f196.google.com with SMTP id w140so4721605vkd.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZf+sHbmvArMQLoAkazBqVMeax+oCtLanIAkBcLHGR4=;
        b=g1N5ibS5tzeO9x3Q0ZGvEuf/DpMARPwJBEoPgx6VOKFqOx4pLtPqavaV4CKZCHsfBj
         UnT9rlzq3Rh/BXaesk0MPfQj8Z5VWRfvKZa7zepXTW4GOI6sPV0rbPEuUIbSnpYbZ86W
         pTYhlFmHp2TUzFuGmtpMryL9tOlGIJSFgW4v9aZ+lff6WQgsLNKkgPHrkbLqM8lrlSOR
         yBAqOMRVk6RddZyudIl7mvugqZATxqUI/LXMQ3byOXE4yQmfZ5XfPlBsxqhHRXJ054G/
         g40FPPROGCjSAxUlDEMGSKSJQrEFRiT6/oMt6QJ34LnwpvqHHf8YjdTD2TOcfgm9wpwf
         GeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZf+sHbmvArMQLoAkazBqVMeax+oCtLanIAkBcLHGR4=;
        b=h+uKEtk+wl+koXWmY5gLkm4ZtfeCGoq7OZTN6U0zSYfsGpy/KGHEgpT421z16hukhM
         dWqfg93JPA2PjPux5w2bYfFJBBC95vNXsdOIQ09mK7wf8r0KRo6xgiSWuMzkleHow/jP
         OQhjP6T1Msm95C4HomgUD2Yj4fD7634zXjyaLQAJD/HlhGyZQ3LhK1cb5HTXALOHKv09
         x9OO/+scjj/2XT2udD8w0kuiGHTf+UYjEtIAK1eVen37yqUl/2+nzA+ahsnA0Jc0XE+2
         L0k/vmE+IZxp7PEvUOF08vdIDhFdpgaiVSiqLKhdV8PYNSQ/rUdRmzjizBf9fDwWkhAV
         544Q==
X-Gm-Message-State: APjAAAWHKZ8Yw3ywZbDXZAzNak7lIe/09vAop5XgsMlRs0wzkqBZZV6C
        NTK3cPGNbHREQ/AHnTJ+fRl2n85afB1LEQfvYA+CVg==
X-Google-Smtp-Source: APXvYqwuwiMRCYbTBDlUFM3TqTzdyCR7p+nYZ16YpVZkcC+iEtMjry77/c+0dVH24KWStLkYv39QkCXAZflaQAVS7pE=
X-Received: by 2002:a1f:3103:: with SMTP id x3mr19804998vkx.17.1556187306625;
 Thu, 25 Apr 2019 03:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-4-ulf.hansson@linaro.org> <20190425094502.6wprvxdz44e5g63q@vireshk-i7>
In-Reply-To: <20190425094502.6wprvxdz44e5g63q@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Apr 2019 12:14:30 +0200
Message-ID:
 <CAPDyKFpnFwD09uYBAUMt2umn920aezht6b+B1cAeTNtX4zrSfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] PM / Domains: Search for the CPU device outside the
 genpd lock
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190425101430.8Dz15L_QKnNHnzisNRpZ0wlzy7AE17oX3mWroT8yKRs@z>

On Thu, 25 Apr 2019 at 11:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-04-19, 11:04, Ulf Hansson wrote:
> > While attaching/detaching a device to a PM domain (genpd) that has the
> > GENPD_FLAG_CPU_DOMAIN set, genpd iterates the cpu_possible_mask to check
> > whether the device corresponds to a CPU. This iteration is done while
> > holding the genpd's lock, which is unnecessary. Let's avoid the locking,
> > by restructuring the corresponding code a bit.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 52 +++++++++++++++++++------------------
> >  1 file changed, 27 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 93298b7db408..da1c99178943 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1450,8 +1450,8 @@ static void genpd_free_dev_data(struct device *dev,
> >       dev_pm_put_subsys_data(dev);
> >  }
> >
> > -static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> > -                                int cpu, bool set, unsigned int depth)
> > +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> > +                              int cpu, bool set, unsigned int depth)
> >  {
> >       struct gpd_link *link;
> >
> > @@ -1462,7 +1462,7 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> >               struct generic_pm_domain *master = link->master;
> >
> >               genpd_lock_nested(master, depth + 1);
> > -             __genpd_update_cpumask(master, cpu, set, depth + 1);
> > +             genpd_update_cpumask(master, cpu, set, depth + 1);
> >               genpd_unlock(master);
> >       }
> >
> > @@ -1472,38 +1472,37 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> >               cpumask_clear_cpu(cpu, genpd->cpus);
> >  }
> >
> > -static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> > -                              struct device *dev, bool set)
> > +static void genpd_set_cpumask(struct generic_pm_domain *genpd, int cpu)
> > +{
> > +     if (cpu >= 0)
> > +             genpd_update_cpumask(genpd, cpu, true, 0);
> > +}
> > +
> > +static void genpd_clear_cpumask(struct generic_pm_domain *genpd, int cpu)
> > +{
> > +     if (cpu >= 0)
> > +             genpd_update_cpumask(genpd, cpu, false, 0);
> > +}
> > +
> > +static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
> >  {
> >       int cpu;
> >
> >       if (!genpd_is_cpu_domain(genpd))
> > -             return;
> > +             return -1;
> >
> >       for_each_possible_cpu(cpu) {
> > -             if (get_cpu_device(cpu) == dev) {
> > -                     __genpd_update_cpumask(genpd, cpu, set, 0);
> > -                     return;
> > -             }
> > +             if (get_cpu_device(cpu) == dev)
> > +                     return cpu;
> >       }
> > -}
> >
> > -static void genpd_set_cpumask(struct generic_pm_domain *genpd,
> > -                           struct device *dev)
> > -{
> > -     genpd_update_cpumask(genpd, dev, true);
> > -}
> > -
> > -static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
> > -                             struct device *dev)
> > -{
> > -     genpd_update_cpumask(genpd, dev, false);
> > +     return -1;
> >  }
> >
> >  static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
> >  {
> >       struct generic_pm_domain_data *gpd_data;
> > -     int ret;
> > +     int ret, cpu;
> >
> >       dev_dbg(dev, "%s()\n", __func__);
> >
> > @@ -1514,13 +1513,15 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
> >       if (IS_ERR(gpd_data))
> >               return PTR_ERR(gpd_data);
> >
> > +     cpu = genpd_get_cpu(genpd, dev);
> > +
> >       ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> >       if (ret)
> >               goto out;
> >
> >       genpd_lock(genpd);
> >
> > -     genpd_set_cpumask(genpd, dev);
> > +     genpd_set_cpumask(genpd, cpu);
>
> Should we check if "cpu" is valid here ? As that was done earlier.

This is being done in the new version of genpd_set|clear_cpumask(). Like below.

"if (cpu >= 0)"...

>
> >       dev_pm_domain_set(dev, &genpd->domain);
> >
> >       genpd->device_count++;
> > @@ -1560,13 +1561,14 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> >  {
> >       struct generic_pm_domain_data *gpd_data;
> >       struct pm_domain_data *pdd;
> > -     int ret = 0;
> > +     int cpu, ret = 0;
> >
> >       dev_dbg(dev, "%s()\n", __func__);
> >
> >       pdd = dev->power.subsys_data->domain_data;
> >       gpd_data = to_gpd_data(pdd);
> >       dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
> > +     cpu = genpd_get_cpu(genpd, dev);
> >
> >       genpd_lock(genpd);
> >
> > @@ -1578,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> >       genpd->device_count--;
> >       genpd->max_off_time_changed = true;
> >
> > -     genpd_clear_cpumask(genpd, dev);
> > +     genpd_clear_cpumask(genpd, cpu);
>
> Same here.

See above.

>
> >       dev_pm_domain_set(dev, NULL);
> >
> >       list_del_init(&pdd->list_node);
> > --
> > 2.17.1
>
> --
> viresh

Thanks for reviewing!

Kind regards
Uffe
