From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at Kconfig
Date: Thu, 6 Jun 2013 21:18:17 +0530
Message-ID: <CAKohponnPovZ2txm0FrCfYr_r_M29s73hSQATaHdE61CNfogaQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1370502472-7249-6-git-send-email-l.majewski@samsung.com>
	<20130606144910.GA1194@redhat.com>
	<20130606171431.41d63591@amdc308.digital.local>
	<20130606152104.GA11015@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130606152104.GA11015@redhat.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 6 June 2013 20:51, Dave Jones <davej@redhat.com> wrote:
> Given CPUFREQ is available on more platforms than X86/ARM, this option
> could also use a depends.

It should be disabled by default, so please add default n.
But we don't need a depends here as everybody is open to use
it. Its a core feature.
