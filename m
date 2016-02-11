From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix out of bounds access in
 time_in_idle
Date: Thu, 11 Feb 2016 18:45:04 +0000
Message-ID: <20160211184503.GA5200@e104805>
References: <1455192051-6430-1-git-send-email-javi.merino@arm.com>
 <20160211150027.GA24955@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211150027.GA24955@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: akpm@linux-foundation.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, drinkcat@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 11, 2016 at 07:00:28AM -0800, Eduardo Valentin wrote:
> On Thu, Feb 11, 2016 at 12:00:51PM +0000, Javi Merino wrote:
> > In __cpufreq_cooling_register() we allocate the arrays for time_in_idle
> > and time_in_idle_timestamp to be as big as the number of cpus in this
> > cpufreq device.  However, in get_load() we access this array using the
> > cpu number as index, which can result in an out of bound access.
> > 
> > Index time_in_idle{,_timestamp} using the index in the cpufreq_device's
> > allowed_cpus mask, as we do for the load_cpu array in
> > cpufreq_get_requested_power()
> > 
> > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Tested-by: Nicolas Boichat <drinkcat@chromium.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> 
> > ---
> > Hi Andrew,
> > 
> > This patch fixes an out of bounds access found by Nicolas Boichat
> > using KASAN.  It is acked by Viresh, comaintainer of the cpu cooling
> > device and tested by the reporter.  It's been in the list[0] for more
> > than a month, I've pinged the thermal maintainers three times but they
> > haven't replied.
> > 
> > Can you merge it via your tree?  Thanks,
> > Javi
> 
> Somehow this patch was marked as accepted in patchwork and I missed it,
> apologize for this. I am adding it to thermal-soc.

Great, thanks!
Javi
