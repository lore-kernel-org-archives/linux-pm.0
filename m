From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
Date: Thu, 10 Dec 2015 14:15:04 +0000
Message-ID: <566988E8.3010308@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 23/11/15 14:28, Juri Lelli wrote:
> Add a sysfs cpu_capacity attribute with which it is possible to read and
> write (thus over-writing default values) CPUs capacity. This might be
> useful in situation where there is no way to get proper default values
> at boot time.
> 
> The new attribute shows up as:
> 
>  /sys/devices/system/cpu/cpu*/cpu_capacity
>

This sysfs interface is not really needed for arm or arm64. People can
build the dt blob if they want to change the values. Less code to carry
... Let's focus on the core functionality, which is parsing cpu capacity
from dt file to task scheduler for heterogeneous systems.

[...]
