From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 14/15] cpufreq: Tegra: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 23:10:51 +0200
Message-ID: <7618517.DFSqTW80gq@vostro.rjw.lan>
References: <cover.1375279948.git.viresh.kumar@linaro.org> <7e832fd210488da0675b6c70fc9a3947eec7899d.1375279948.git.viresh.kumar@linaro.org> <51F961C5.7070302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F961C5.7070302@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 31, 2013 01:13:09 PM Stephen Warren wrote:
> On 07/31/2013 08:19 AM, Viresh Kumar wrote:
> > CPUFreq core does following at multiple places:
> > module_{get|put}(cpufreq_driver->owner)).
> > 
> > This is done to make sure module doesn't get unloaded if it is currently in use.
> > This will work only if the .owner field of cpufreq driver is initialized with a
> > valid pointer.
> > 
> > This field wasn't initialized for this driver, lets initialize it with
> > THIS_MODULE.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> I assume this is all part of a series you'll take through the cpufreq tree.

I'm going to apply this series eventually, but I'd like some ACKs to accumulate
before doing that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
