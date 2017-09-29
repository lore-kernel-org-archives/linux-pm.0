From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Fri, 29 Sep 2017 18:46:58 +0200
Message-ID: <552ee23d-48b0-a9cf-8981-4584282a4f9c@linaro.org>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
 <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:52740 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdI2QrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 12:47:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id p87so94237pfj.9
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2017 09:47:01 -0700 (PDT)
In-Reply-To: <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Schneider <valentin.schneider@arm.com>, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, Leo Yan <leo.yan@linaro.org>


Hi Valentin,

On 29/09/2017 13:07, Valentin Schneider wrote:

[ ... ]

> I've tested this on HiKey960 (Android 4.9 + upstream patches to apply
> your thermal/drivers/hisi series + Kevin's hi3600 support).
> I ran a video workload, and noticed I get several interrupts while
> passive cooling is already in effect
> (I might move part of this discussion to Kevin's posting, but I think
> it's still relevant to be here):
> 
> [  118.107357] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
> [  119.182531] hisi_thermal fff30000.tsensor: THERMAL ALARM: 76235 > 65000
> [  119.361964] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
> [  119.907865] hisi_thermal fff30000.tsensor: THERMAL ALARM: 75620 > 65000
> [  119.959076] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70700 > 65000
> 
> This isn't optimal for IPA, as the PID is supposed to use a specific
> sampling rate, but those interrupts
> forced a re-trigger of power_allocator_throttle which changes the PID's
> actual sampling rate.
> IPA isn't expecting this kind of scenarios, as I can see a
> tz->passive_delay in the computation
> of the derivative term (although the derivative coefficient defaults to
> 0...).

Interesting. This patch actually is for the hikey, not for the hikey960.
I didn't tested with Kevin's patches.

The thermal characteristics are very different on hi960. For example,
the temperature increase is must faster on hikey960. So I guess, the
driver itself should be fine tuned to prevent this kind of scenario.

> In a perfect world I would see those interrupts being toggled by the
> thermal governor, as that is
> where we know what to do with each trip point - we could still want the
> interrupts, but in the case
> of IPA we'd like to disable them while the PID controller is active, and
> we would know when to re-enable them
> (as soon as IPA is toggled off).
Yes, that is true the thermal framework could be enhanced to support this.

Do you have an hikey (not 960) to test this patch?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
