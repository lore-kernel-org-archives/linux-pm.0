From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/5] PM / OPP: check for existing OPP list when
 initialising from device tree
Date: Thu, 3 Oct 2013 10:24:58 +0530
Message-ID: <CAKohpomi_+YY53nL-uj50Qc5LCZZFtBz25Bu7ZEuA==WUMZENg@mail.gmail.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
	<1380634382-15609-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1380634382-15609-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 1 October 2013 19:03, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>
> CPUs are registered as devices and their OPPs can be initialised from
> the device tree. Whenever CPUs are hotplugged out, the corresponding
> cpu devices are not removed. As a result all their OPPs remain intact
> even when they are offlined.
>
> But when they are hotplugged back-in, the cpufreq along with other cpu
> related subsystem gets re-initialised. Since its almost same as secondary
> cpu being brought up, no special consideration is taken in the hotplug
> path. This may result in cpufreq trying to initialise the OPPs again though
> the cpu device already contains the OPPs.
>
> This patch checks if there exist an OPP list associated with the device,
> before attempting to initialise it.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  drivers/base/power/opp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
