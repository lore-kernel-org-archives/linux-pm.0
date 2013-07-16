From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 4/7] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Tue, 16 Jul 2013 15:18:57 +0530
Message-ID: <CAKohpokiF8ZamE_=XdPrjZQ8VHQ9wvzQy6w+6byO-T7J9c=6mA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1372927830-2949-5-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> The struct cpufreq_driver has been extended to embrace the information
> related to boost support.
>
> When "boost_mode" device tree attribute is defined for a platform, the
> boost_supported flag is set. Moreover boost related attributes were
> exported.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

Don't we need to mark any frequencies in the freq table with BOOST?
How?
