From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 4/7] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Tue, 16 Jul 2013 12:58:48 +0200
Message-ID: <20130716125848.770ba264@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-5-git-send-email-l.majewski@samsung.com>
 <CAKohpokiF8ZamE_=XdPrjZQ8VHQ9wvzQy6w+6byO-T7J9c=6mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokiF8ZamE_=XdPrjZQ8VHQ9wvzQy6w+6byO-T7J9c=6mA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Jul 2013 15:18:57 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > The struct cpufreq_driver has been extended to embrace the
> > information related to boost support.
> >
> > When "boost_mode" device tree attribute is defined for a platform,
> > the boost_supported flag is set. Moreover boost related attributes
> > were exported.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> 
> Don't we need to mark any frequencies in the freq table with BOOST?
> How?

The (trivial) patch is already prepared to enable BOOST at cpufreq for
Exynos4412. I will post it for v6. Sorry for not posting it earlier.

The whole patch is as follow:

static struct clk *cpu_clk;
static struct clk *mout_core;
static struct clk *sclk_mpll;
static struct clk *mout_apll;
 
static unsigned int exynos4x12_volt_table[] = {
	1350000, 1287500, 1250000, 1187500, 1137500, 1087500, 1037500,
 	1000000,  987500,  975000,  950000,  925000,  900000,  900000
};
 
 static struct cpufreq_frequency_table exynos4x12_freq_table[] = {
-	{L0, CPUFREQ_ENTRY_INVALID},
+	{CPUFREQ_BOOST_FREQ, 1500 * 1000},
 	{L1, 1400 * 1000},
 	{L2, 1300 * 1000},
 	{L3, 1200 * 1000},
 	{L4, 1100 * 1000},
 	{L5, 1000 * 1000},
 	{L6,  900 * 1000},
 	{L7,  800 * 1000},
 	{L8,  700 * 1000},
 	{L9,  600 * 1000},
 	{L10, 500 * 1000},
 	{L11, 400 * 1000},
 	{L12, 300 * 1000},



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
