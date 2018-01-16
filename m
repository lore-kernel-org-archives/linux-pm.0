From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] thermal: Add cooling device's statistics in sysfs
Date: Tue, 16 Jan 2018 15:30:42 +0530
Message-ID: <20180116100042.GJ22978@vireshk-i7>
References: <087186fecdfd85bead58e110cf8bf7ccdfab517b.1515663078.git.viresh.kumar@linaro.org>
 <20180112174606.GA11076@localhost.localdomain>
 <20180115044616.GC22978@vireshk-i7>
 <20180115163221.GA3756@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33519 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeAPKAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jan 2018 05:00:46 -0500
Received: by mail-pg0-f50.google.com with SMTP id i196so9247652pgd.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2018 02:00:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180115163221.GA3756@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-01-18, 08:32, Eduardo Valentin wrote:
> Same set you added for cooling devices should also be reflected on
> thermal zones, but instead of cooling state, you want to do the account
> on trips, at least for the context of this patch set.

I never dived deep into the thermal core earlier and never had to implement any
SoC side of it as well, so consider me a newbie here :)

I tried to look into the core on what I can do to get some stats out for the
zones, but I am a bit confused.

handle_thermal_trip() looked to be the function where I could update stats but
then I realized that this is artificially called for every possible trip in most
of the cases from thermal_zone_device_update() and so this can't be the real
place.

Does it mean that this needs to be updated somehow from the thermal governor's,
->throttle() callback? I am not sure if doing it from every governor code is
what we want to do. And then the trip point of cooling devices can be different
within the same thermal zone.

And so I posted the first patch again without thermal zone stuff in it as that
would take more time.

-- 
viresh
