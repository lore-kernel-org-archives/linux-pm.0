From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 4/4] cpufreq: Add Kconfig option to enable/disable have_multiple_policies
Date: Tue, 12 Mar 2013 08:55:12 +0800
Message-ID: <CAKohpompsA5bR6TauM7Wa6ciLxYYc7GdpN1NXdHF_WbP2ki=qA@mail.gmail.com>
References: <cover.1362381470.git.viresh.kumar@linaro.org>
	<b3deff3c75a0ca1b687c92bf81061c3728346494.1362381470.git.viresh.kumar@linaro.org>
	<1687194.MelaMkNoiM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1687194.MelaMkNoiM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 12 March 2013 07:38, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> One more question before I apply it.
>
> Is there any architecture/platform that will set
> CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES and keep have_multiple_policies unset
> at the same time?

No, they are redundant. That's why i have been forcing to drop this patch.
