From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 04/10] arm: wire cpufreq input data for
 frequency-invariant accounting up to the arch
Date: Tue, 11 Jul 2017 12:02:24 +0530
Message-ID: <20170711063224.GN2928@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-5-dietmar.eggemann@arm.com>
 <20170706104258.GC13048@vireshk-i7>
 <de625d21-6e2c-0a3f-85be-bff70d24ea61@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <de625d21-6e2c-0a3f-85be-bff70d24ea61@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 10-07-17, 16:13, Dietmar Eggemann wrote:
> Since 'arch/$ARCH/include/asm/topology.h' now includes
> 'include/linux/arch_topology.h' and 'arch/$ARCH/kernel/topology.c'
> already includes 'arch/$ARCH/include/asm/topology.h' I thought it's a
> good idea to get rid of this include here.

Ahh, makes sense.

-- 
viresh
