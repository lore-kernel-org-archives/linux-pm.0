From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/18] cpufreq: powerpc/platforms/cell: move cpufreq driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 14:48:10 +0000
Message-ID: <201304041448.11052.arnd@arndb.de>
References: <cover.1365079581.git.viresh.kumar@linaro.org> <201304041302.09995.arnd@arndb.de> <CAKohpok_ftPoME0tFRMWMM9A2mNSOpQSvbJut0=AzhCuB-Yjrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpok_ftPoME0tFRMWMM9A2mNSOpQSvbJut0=AzhCuB-Yjrg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Thursday 04 April 2013, Viresh Kumar wrote:
> 
> On 4 April 2013 18:32, Arnd Bergmann <arnd@arndb.de> wrote:
> > Moving the files is good, but I don't see a reason to make the cbe_cpufreq.h
> > header globally visible in include/linux/. Isn't it just used by as the
> > interface between ppc_cbe_cpufreq_pmi.c  and ppc_cbe_cpufreq.c?
> 
> When i moved it initially i thought it is also used by
> arch/powerpc/platforms/cell/cpufreq_spudemand.c and hence moved it
> to include/linux and never realized i am wrong..
> 
> Here is the fixup (And attached complete patch: original+fixup for Rafael
> to apply):


Acked-by: Arnd Bergmann <arnd@arndb.de>
