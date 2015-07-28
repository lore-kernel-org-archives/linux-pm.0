From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 5/8] cpufreq: arm_big_little: add SCPI interface driver
Date: Tue, 28 Jul 2015 11:20:32 +0100
Message-ID: <55B75770.6080403@arm.com>
References: <1437649828-14540-1-git-send-email-sudeep.holla@arm.com> <1437649828-14540-6-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437649828-14540-6-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 23/07/15 12:10, Sudeep Holla wrote:
> On some ARM based systems, a separate Cortex-M based System Control
> Processor(SCP) provides the overall power, clock, reset and system
> control including CPU DVFS. SCPI Message Protocol is used to
> communicate with the SCPI.
>
> This patch adds a interface driver for adding OPPs and registering
> the arm_big_little cpufreq driver for such systems.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> ---
>   MAINTAINERS                    |   1 +
>   drivers/cpufreq/Kconfig.arm    |   9 +++
>   drivers/cpufreq/Makefile       |   1 +
>   drivers/cpufreq/scpi-cpufreq.c | 124 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 135 insertions(+)
>   create mode 100644 drivers/cpufreq/scpi-cpufreq.c
>
> Hi Rafael,
>
> Viresh has already ACKed, since I plan to push this as a series via arm-soc,
> can you provide your ACK if the patch looks fine to you ?
>

Any objections to take it via ARM-SoC ? If not can you please provide ACK ?

Regards,
Sudeep
