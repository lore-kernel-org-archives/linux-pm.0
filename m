From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v10 2/6] PM / Domains: core changes for multiple states
Date: Tue, 10 Nov 2015 12:02:28 +0100
Message-ID: <5641CEC4.3080800@baylibre.com>
References: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>	<1445347589-5626-3-git-send-email-ahaslam@baylibre.com> <CAN2waFuQ+72zstgdD7GbxOr=d1T1wkqRvRePfL8KJbTceEGdzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36834 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbKJLCb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 06:02:31 -0500
Received: by wmww144 with SMTP id w144so112327849wmw.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2015 03:02:30 -0800 (PST)
In-Reply-To: <CAN2waFuQ+72zstgdD7GbxOr=d1T1wkqRvRePfL8KJbTceEGdzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Zhaoyang,

>     @@ -576,6 +584,8 @@ static void pm_genpd_sync_poweroff(struct
>     generic_pm_domain *genpd,
>                  || atomic_read(&genpd->sd_count) > 0)
>                      return;
>
>     +       /* Choose the deepest state when suspending */
>     +       genpd->state_idx = genpd->state_count - 1;
>
> if there is no governor configured, does it mean that we just try the
> deepest one here?
>

If a governor is not configured, there is no way to choose between the 
states, and the state_idx will not change. so it will remain the one set 
at the genpd init function wich is the same as here: the deepest state. 
(state_count -1). In other words, if there is no governor, there
is only one state: the deepest.

About setting the deepest state in this particular place, My 
understanding is that this code will be called in suspend path,
and in this case genpd_poweroff is not called, hence the genpd governor 
is not called either. Because there are many other things happening 
during suspend/resume, i think that suspend/resume is a slow procedure 
that will most likely not honor the device qos constraints, so i set the 
genpd to its deepest state.

Regards
Axel
>              genpd_power_off(genpd, timed);
>
>              genpd->status = GPD_STATE_POWER_OFF;
