From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 05/11] PM / devfreq: governors: Return device frequency
 limits instead of user limits
Date: Mon, 28 May 2018 14:04:44 +0900
Message-ID: <20180528050444epcms1p8e6552d55231a099ec89304dfb1f819b9@epcms1p8>
References: <20180525203043.249193-6-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203125epcas3p46c7cac352ede4b0ba5d2b36bc32ad566@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525203043.249193-6-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

>The performance, powersave and simpleondemand governors can return
>df->min/max_freq, which are the user defined frequency limits.
>update_devfreq() already takes care of adjusting the target frequency
>with the user limits if necessary, therefore we can return
>df->scaling_min/max_freq instead, which is the min/max frequency
>supported by the device at a given time (depending on the
>enabled/disabled OPPs)
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor_performance.c    | 2 +-
> drivers/devfreq/governor_powersave.c      | 2 +-
> drivers/devfreq/governor_simpleondemand.c | 6 +++---
> 3 files changed, 5 insertions(+), 5 deletions(-)
>

Actually, even scaling_max_freq and scaling_min_freq are
covered centerally at devfreq.c:update_devfreq();

Wouldn't it be sufficient to return UINT_MAX for performance
and return UINT_MIN (0) for powersave, if the purpose is to
remove redundancy?

In the same sense, we may return UINT_MAX for freq-increasing
case for simpleondemand as well, because they are filtered
centrally anyway.

(This commit might be better merged to 4/11 in that case as well.)


Cheers,
MyungJoo
