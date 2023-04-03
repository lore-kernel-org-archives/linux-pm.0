Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F03C76188
	for <linux-pm@archiver.kernel.org>; Mon,  3 Apr 2023 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjDCRvM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjDCRus (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 13:50:48 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B635AA;
        Mon,  3 Apr 2023 10:50:17 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id y4so120637365edo.2;
        Mon, 03 Apr 2023 10:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trLwUHvcK3wHkon8F/JeJDMZBlFlnvHVyUuthBunhUo=;
        b=Vw/Y/IpCrcWQvKyifLHPKXpECid8or3RoecQeZPTA6phtWX/LyzcFRd/IkwnnBIPCE
         B4bVHj/4j0SXqWUnuAV7RBeyLrfyqX+K/FfT4H6acDWmO4/C0hFW6dGlu3HltvtaG4VS
         oYYqaMHHW2Zn3xkE30PAUy9Vk+7Au4CefVbNhCQV/0ntxnqmjiZAncyHF8ynbH2RC0v0
         AjpXM59gJQGnZzgnC80Kw/a7nKgHKHRLQga77NA8qrIip71eoqwb3iO4hdP8Qur2XbQw
         HrkwOXmx8BQffZsZApvlp6WR5XIc2vDXQT8NPuFbwFgQy9BFEpz8IUdlETaOb3/lT4CG
         gpGg==
X-Gm-Message-State: AAQBX9eAri3NaENRkXKFb2aWU3EreQGhVEwrRh9cwzGkBbhhp+gu0bH2
        sjpMrdimxPBPxfyQLVpZMzRWiLfr3kjhgRfrbqE=
X-Google-Smtp-Source: AKy350aMAMThM2sVQhdgQAtnQDKKZbUV+QqdzwDZGN8sDSUN1jdT3Iw8qMrz82dK2CRAWq127a7+ahqf+jd50nNEW1E=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr20289358ejc.2.1680544193791; Mon, 03
 Apr 2023 10:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <2696911.mvXUDI8C0e@kreacher> <3dbb630f-abf9-4d09-f1fd-b2b05013c5dd@linaro.org>
In-Reply-To: <3dbb630f-abf9-4d09-f1fd-b2b05013c5dd@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:49:42 +0200
Message-ID: <CAJZ5v0iueAzQ2mg0svfNJGvqL=dKtb1ibKxfGNyJVfnaeEfrOw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Clean up thermal_list_lock locking
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 1, 2023 at 10:45 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/03/2023 20:34, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Once thermal_list_lock has been acquired in
> > __thermal_cooling_device_register(), it is not necessary to drop it
> > and take it again until all of the thermal zones have been updated,
> > so change the code accordingly.
> >
> > No expected functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Looks good to me, shall I pick it in my branch ?

No, I;ll take care of it myself, thanks!

> >   drivers/thermal/thermal_core.c |    8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -826,8 +826,6 @@ static void bind_cdev(struct thermal_coo
> >       const struct thermal_zone_params *tzp;
> >       struct thermal_zone_device *pos = NULL;
> >
> > -     mutex_lock(&thermal_list_lock);
> > -
> >       list_for_each_entry(pos, &thermal_tz_list, node) {
> >               if (!pos->tzp && !pos->ops->bind)
> >                       continue;
> > @@ -854,8 +852,6 @@ static void bind_cdev(struct thermal_coo
> >                              tzp->tbp[i].weight);
> >               }
> >       }
> > -
> > -     mutex_unlock(&thermal_list_lock);
> >   }
> >
> >   /**
> > @@ -933,17 +929,17 @@ __thermal_cooling_device_register(struct
> >
> >       /* Add 'this' new cdev to the global cdev list */
> >       mutex_lock(&thermal_list_lock);
> > +
> >       list_add(&cdev->node, &thermal_cdev_list);
> > -     mutex_unlock(&thermal_list_lock);
> >
> >       /* Update binding information for 'this' new cdev */
> >       bind_cdev(cdev);
> >
> > -     mutex_lock(&thermal_list_lock);
> >       list_for_each_entry(pos, &thermal_tz_list, node)
> >               if (atomic_cmpxchg(&pos->need_update, 1, 0))
> >                       thermal_zone_device_update(pos,
> >                                                  THERMAL_EVENT_UNSPECIFIED);
> > +
> >       mutex_unlock(&thermal_list_lock);
> >
> >       return cdev;
> >
> >
> >
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
