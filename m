From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Date: Mon, 18 Feb 2019 13:33:11 +0900
Message-ID: <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
References: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "tkjos@google.com" <tkjos@google.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>, "chris.diamand@arm.com" <chris.diamand@arm.com>, "mka@chromium.org" <mka@chromium.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

> This patch adds new mechanism for devfreq devices which changes polling
> interval. The system should sleep longer when the devfreq device is almost
> not used. The devfreq framework will not schedule the work too often.
> This low-load state is recognised when the device is operating at the lowest
> frequency and has low busy_time/total_time factor (< 30%).
> When the frequency is different then min, the device is under normal polling
> which is the value defined in driver's 'polling_ms'.
> When the device is getting more pressure, the framework is able to catch it
> based on 'load' in lowest frequency and will start polling more frequently.
> The second scenario is when the governor recognised heavy load at minimum
> frequency and increases the frequency. The devfreq framework will start
> polling in shorter intervals.
> The polling interval, when the device is not heavily, can also be changed
> from userspace of defined by the driver's author.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
>  drivers/devfreq/governor.h                |   3 +-
>  drivers/devfreq/governor_simpleondemand.c |   6 +-
>  3 files changed, 145 insertions(+), 15 deletions(-)
> 

There are some requirements that you need to consider:

Is 30% really applicable to ALL devfreq devices?
    - What if some devices do not want such behaviors?
    - What if some devices want different values (change behavors)?
    - What if some manufactures want different default values?
    - What if some devices want to let the framework know that it's in idle?
    - What if some other kernel context, device (drivers),
    or userspace process want to notify that it's no more idling?

As mentioned in the internal thread (tizen.org),
I'm not convinced by the idea of assuming that a device can be considered "idling"
if it has simply "low" utilization.

You are going to deteriorate the UI response time of mobile devices significantly.

Cheers,
MyungJoo.
