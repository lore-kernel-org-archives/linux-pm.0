From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: cpufreq: powernv: Remove global pstate ramp-down timer in POWER9
Date: Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
Message-ID: <41WNpb24Jbz9s21@ozlabs.org>
References: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-04-25 at 06:14:55 UTC, Shilpasri G Bhat wrote:
> POWER9 doesnot support global pstate requests for the chip. So remove
> the timer logic which slowly ramps down the global pstate in P9
> platforms.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dcb14337e0f2adb227c376e6327ef0

cheers
