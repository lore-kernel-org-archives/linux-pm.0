From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] cpufreq: remove sysfs link when a cpu != policy->cpu,
 is removed
Date: Tue, 18 Feb 2014 13:05:59 -0700
Message-ID: <5303BD27.4000905@wwwdotorg.org>
References: <324f43fc664f51eec355b08b6c2d4cedd2140b4c.1392628861.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <324f43fc664f51eec355b08b6c2d4cedd2140b4c.1392628861.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/17/2014 02:22 AM, Viresh Kumar wrote:
> Earlier patch tried to do this but missed this piece of code to fix.
> 
> 42f921a cpufreq: remove sysfs files for CPUs which failed to come back after
> resume
> 
> Currently we are getting this on suspend/resume:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 877 at fs/sysfs/dir.c:52 sysfs_warn_dup+0x68/0x84()
> sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
...
> Fix this by removing sysfs link for cpufreq directory when cpu removed isn't
> policy->cpu.

Tested-by: Stephen Warren <swarren@nvidia.com>
