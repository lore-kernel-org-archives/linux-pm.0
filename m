From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Add governor operation ongoing flag
Date: Wed, 14 Aug 2013 10:51:47 +0530
Message-ID: <CAKohpo=QKPvqUcQVsbbSQdWOOi5L-P2CBFzcfMsobs8uGpLkVw@mail.gmail.com>
References: <1376377766-2594-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1376377766-2594-1-git-send-email-chenxg@marvell.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg@marvell.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Xiaoguang Chen <chenxg.marvell@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 12:39, Xiaoguang Chen <chenxg@marvell.com> wrote:
> __cpufreq_governor operation needs to be executed one by one.
> If one operation is ongoing, the other operation can't be executed.
> If the order is not guaranteed, there may be unexpected behavior.

What order??

>  For example, governor is in enable state, and one process
> tries to stop the goveror, but it is scheduled out before policy->
> governor->governor() is executed, but the governor enable flag is
> set to false already. Then one other process tries to start governor,
> It finds enable flag is false, and it can process down to do governor
> start operation, So the governor is started twice.

That's not possible. A process will not and should not call START
before calling STOP. And so the order of calling these routines must
be forced.

Hence, we may not need your patch.
