From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
Date: Wed, 04 Jul 2018 11:27:54 +0900
Message-ID: <5B3C30AA.3070302@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235028epcas4p2921421ea854565c23dfa54db9fb6ada8@epcas4p2.samsung.com>
        <20180703234705.227473-4-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180703234705.227473-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Several governors use the user space limits df->min/max_freq to adjust
> the target frequency. This is not necessary, since update_devfreq()
> already takes care of this. Instead the governor can request the available
> min/max frequency by setting the target frequency to DEVFREQ_MIN/MAX_FREQ
> and let update_devfreq() take care of any adjustments.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
>   and "PM / devfreq: governors: Return device frequency limits instead of user
>   limits"
> - updated subject and commit message
> - use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq
> ---
>  drivers/devfreq/governor.h                |  3 +++
>  drivers/devfreq/governor_performance.c    |  5 +----
>  drivers/devfreq/governor_powersave.c      |  2 +-
>  drivers/devfreq/governor_simpleondemand.c | 12 +++---------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  5 files changed, 12 insertions(+), 26 deletions(-)

Actually, I preferred to use 'df->scaling_min/max_freq'
instead of DEVFREQ_MIN/MAX_FREQ. But, DEVFREQ_MIN/MAX_FREQ is other way. 

So, Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
