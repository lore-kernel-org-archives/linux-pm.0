From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH v2 0/5] ARM: vexpress/TC2: cpufreq support
Date: Mon, 21 Oct 2013 11:46:04 +0100
Message-ID: <1382352364.3332.4.camel@hornet>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2013-10-21 at 10:58 +0100, Sudeep KarkadaNagesha wrote:
> Sudeep KarkadaNagesha (5):
>   cpufreq: arm-big-little: use clk_get instead of clk_get_sys
>   ARM: vexpress/TC2: add support for CPU DVFS
>   ARM: vexpress/TC2: add cpu clock support
>   cpufreq: arm_big_little: add vexpress SPC interface driver
>   ARM: vexpress/TC2: register vexpress-spc cpufreq device
>=20
>  arch/arm/mach-vexpress/Kconfig         |  12 ++
>  arch/arm/mach-vexpress/Makefile        |   3 +-
>  arch/arm/mach-vexpress/spc.c           | 366 +++++++++++++++++++++++=
+++++++++-
>  arch/arm/mach-vexpress/spc.h           |   2 +-
>  arch/arm/mach-vexpress/tc2_pm.c        |   7 +-

=46or the vexpress bits and pieces:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawe=C5=82


