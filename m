From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/8] cpufreq: Store cpufreq policies in a list
Date: Fri, 26 Jul 2013 15:44:29 +0530
Message-ID: <CAKohpoktwZUvs2ap7wk1tudVsiKjbhFkoM5=+AaFZP=+73fEyg@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-2-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1374770011-22171-2-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Policies available in a cpufreq framework are now linked together. They are
> accessible via cpufreq_policy_list defined at cpufreq core.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

Looks good but would have been better if you could have moved
existing code to use this infrastructure..

For example, this code in __cpufreq_add_dev()

#ifdef CONFIG_HOTPLUG_CPU
	/* Check if this cpu was hot-unplugged earlier and has siblings */
	read_lock_irqsave(&cpufreq_driver_lock, flags);
	for_each_online_cpu(sibling) {

         ---

	}
	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
#endif
