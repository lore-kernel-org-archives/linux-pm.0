From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 02/11] ARM: DT/kernel: define ARM specific arch_of_get_cpu_node
Date: Tue, 16 Jul 2013 11:59:11 +0530
Message-ID: <CAKohponBwiHfty8er+xhT7CksfFDYZ=3cNyvZA-G0UDCj=tLsA@mail.gmail.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
	<1373883732-26303-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
	<51E44943.7000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51E44943.7000600@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sudeep.KarkadaNagesha@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, rob.herring@calxeda.com, rjw@sisk.pl, grant.likely@linaro.org, cpufreq@vger.kernel.org, kernel@pengutronix.de, gregkh@linuxfoundation.org, olof@lixom.net, gregory.clement@free-electrons.com, shawn.guo@linaro.org
List-Id: linux-pm@vger.kernel.org

On 16 July 2013 00:40, Rob Herring <robherring2@gmail.com> wrote:
> The powermac cpufreq driver could probably also be converted
> (arch/powerpc/platforms/powermac/cpufreq_64.c).

Its called: drivers/cpufreq/pmac64-cpufreq.c now.
