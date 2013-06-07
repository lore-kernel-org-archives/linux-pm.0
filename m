From: Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH] ACPI: update user_policy.max when _PPC updated
Date: Fri, 07 Jun 2013 09:48:36 +0800
Message-ID: <51B13BF4.7090706@oracle.com>
References: <51AE8BE4.8050409@oracle.com> <42861210.QMFsUVH8RU@vostro.rjw.lan> <51B08EB7.8080702@oracle.com> <2674436.upogMLa2Oh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2674436.upogMLa2Oh@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Neil Gu <qing.gu@oracle.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/07/13 03:54, Rafael J. Wysocki wrote:
> Do you mean you set a limit in the BIOS setup and the kernel changed that limit
> on boot?

Sorry for the confusing.

The issue is when we disable hardcap before kernel boot up, after kernel bring
up, any changes of _PPC will update scaling_max_freq properly.

If we enable hardcap before kernel boot up, after kernel bring up, even we 
disable it, scaling_max_freq does not be updated to max frequency, the max 
frequency just up to the value when bring up.

Review related codes I found the limit came from user_policy.max, means when
we set user_policy.max to 1000MHZ when boot up, then any changes of _PPC could
not enlarge the scaling_max_freq, I think this is not as expected? please advise.

Thanks,
Joe
