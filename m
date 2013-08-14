From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Add governor operation ongoing flag
Date: Wed, 14 Aug 2013 13:18:05 +0530
Message-ID: <CAKohponD2LdDsJy=UJCf-1yANjyPjmAyokV5a4HOSJn_DMJVhA@mail.gmail.com>
References: <1376377766-2594-1-git-send-email-chenxg@marvell.com>
	<CAKohpo=QKPvqUcQVsbbSQdWOOi5L-P2CBFzcfMsobs8uGpLkVw@mail.gmail.com>
	<CAFgnuDes_F7Q5CHbXKC=ndrn9Gr3PJfGj0QvDXA-FuGcq41CHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDes_F7Q5CHbXKC=ndrn9Gr3PJfGj0QvDXA-FuGcq41CHQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

I am still not sure if I got what you are trying to say, sorry :(

On 14 August 2013 13:06, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> Please see below code in __cpufreq_governor function
>
> mutex_lock(&cpufreq_governor_lock);
> if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
>                             //////////// <1> Here one process A tries
> to stop governor, it finds governor is enabled, so it will pass down.
>    (policy->governor_enabled && (event == CPUFREQ_GOV_START))) {
>                           /////////////<3> Process B tries to start
> governor, it finds enable flag is false, so it can also pass down.

Processes aren't allowed to call START/STOP in random manner. They
must do a STOP first, if it succeeds do a START.

So lets see it this way:

Process A                            Process B
STOP
                                            STOP
                                            START (If STOP passed)
START (If STOP passed)

So, Process B tries to STOP/START after governor is Stopped by A.
Now call to STOP for process B will fail as we are already stopped..

Can you explain with this example the problem you are trying to solve?
