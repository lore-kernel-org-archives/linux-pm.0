From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 07/11] PM / devfreg: Add support policy notifiers
Date: Mon, 28 May 2018 14:19:49 +0900
Message-ID: <20180528051949epcms1p3bedd6ac3e2f20d0bcd8cb082349d97fa@epcms1p3>
References: <20180525203043.249193-8-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203128epcas5p138dbf89498c03bc2a9221aa662001fd4@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525203043.249193-8-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

>Policy notifiers are called before a frequency change and may narrow
>the min/max frequency range in devfreq_policy, which is used to adjust
>the target frequency if it is beyond this range.
>
>Also add a few helpers:
> - devfreq_verify_within_[dev_]limits()
>    - should be used by the notifiers for policy adjustments.
> - dev_to_devfreq()
>    - lookup a devfreq strict from a device pointer
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++-------
> include/linux/devfreq.h   | 66 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+), 11 deletions(-)

Hello Matthias,


Why should we have yet another notifier from an instance of devfreq?
Wouldn't it better to let the current notifier (transition notifier)
handle new events as well by adding possible event states to it?

Anyway, is this the reason why you've separated some data of devfreq
into "policy" struct? (I was wondering why while reading commit 6/11).


Cheers
MyungJoo
