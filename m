From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Thu, 21 Dec 2017 11:13:57 +0100
Message-ID: <CAPDyKFqa5Lt6jrDQd+V_cE+Bz2ZRJRe95-8bbJgV=LbkGPM0mw@mail.gmail.com>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
 <1513353391-30806-2-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0hctW_-WR2Gy4tszeXYJJfTRQbLCr_NRhAXao5_XR5NOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36024 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdLUKN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 05:13:59 -0500
Received: by mail-it0-f43.google.com with SMTP id d16so10249618itj.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2017 02:13:58 -0800 (PST)
In-Reply-To: <CAJZ5v0hctW_-WR2Gy4tszeXYJJfTRQbLCr_NRhAXao5_XR5NOw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 21 December 2017 at 02:43, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 15, 2017 at 4:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The PM core in the device_prepare() phase, resets the wakeup_path status
>> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
>> ->suspend() callback for the device would update the device's wakeup
>> setting, this doesn't become reflected in the wakeup_path status flag.
>>
>> In general this isn't a problem, because wakeup settings isn't supposed to
>> be changed during those system suspend phases. Nevertheless, there are a
>> cases not conforming to that behaviour, as device_set_wakeup_enable() is
>> indeed called from ->suspend() callbacks.
>
> And why is this regarded as correct?

I am not saying that this behavior is correct. However, I am trying to
improve the situation, which doesn't hurt or does it?

More importantly, the next patch, which is about the wakeup path,
depends on this.

Kind regards
Uffe
