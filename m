From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: integrator: fixed coding style issues
Date: Mon, 13 Jul 2015 08:01:46 +0530
Message-ID: <20150713023146.GC10415@linux>
References: <1436553735-17622-1-git-send-email-cristian97.ardelean@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436553735-17622-1-git-send-email-cristian97.ardelean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cristian Ardelean <cristian97.ardelean@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10-07-15, 14:42, Cristian Ardelean wrote:
> Fixed coding style issues found by checkpatch.pl tool. Changed
> space indentation to tab, removed unneccesary braces, removed
> space between MODULE macros and parentheses.
> 
> REMARKS: failed to 'make' this file with error message
> 'fatal error: asm/mach-types.h: No such file or directory'.
> 
> Signed-off-by: Cristian Ardelean <cristian97.ardelean@gmail.com>
> ---
>  drivers/cpufreq/integrator-cpufreq.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
