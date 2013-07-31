From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 14/15] cpufreq: Tegra: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 13:13:09 -0600
Message-ID: <51F961C5.7070302@wwwdotorg.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org> <7e832fd210488da0675b6c70fc9a3947eec7899d.1375279948.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7e832fd210488da0675b6c70fc9a3947eec7899d.1375279948.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 07/31/2013 08:19 AM, Viresh Kumar wrote:
> CPUFreq core does following at multiple places:
> module_{get|put}(cpufreq_driver->owner)).
> 
> This is done to make sure module doesn't get unloaded if it is currently in use.
> This will work only if the .owner field of cpufreq driver is initialized with a
> valid pointer.
> 
> This field wasn't initialized for this driver, lets initialize it with
> THIS_MODULE.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this is all part of a series you'll take through the cpufreq tree.
