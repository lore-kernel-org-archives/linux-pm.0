From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/7] cpufreq: arm_big_little: don't initialize opp table
Date: Wed, 21 May 2014 18:59:44 +0530
Message-ID: <CAKohpo=FAsaeAiXM-hfdCPHYrV8ALKk5AhLUHO2Ja2P2zyEbQw@mail.gmail.com>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
	<2c310ea534ac3cc181937bc8adf87c4695d6eb70.1400670427.git.viresh.kumar@linaro.org>
	<CAOqmu80Q6_isHyZ89qu7fEj6GQjst_sBCRUTVyopdMthq7d=mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOqmu80Q6_isHyZ89qu7fEj6GQjst_sBCRUTVyopdMthq7d=mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 21 May 2014 17:05, Inderpal Singh <inderpal.s@samsung.com> wrote:
> I guess you wanted to say "cpu core code" instead of "cpufreq core".
> Correction may be needed here and in the subsequent patches as well.

When I started implementation, I added code to cpufreq core's init
routine and later moved it to base/cpu.c .. And just forgot to update
it later :(

Thanks for letting me know
