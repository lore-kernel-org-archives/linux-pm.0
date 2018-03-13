From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Date: Tue, 13 Mar 2018 14:06:53 +0530
Message-ID: <20180313083653.GA15832@vireshk-i7>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
 <1520924571.3766.8.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520924571.3766.8.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-03-18, 15:02, Zhang Rui wrote:
> Hi, Viresh,
> 
> I will queue it for 4.17, with just one minor fix below.
> 
> On 二, 2018-01-16 at 15:22 +0530, Viresh Kumar wrote:

> > +	cdev->stats = stats;
> > +	stats->last_time = ktime_get();
> > +	stats->max_states = states;
> > +	cdev->stats = stats;
> > +
> 
> cdev->stats is set twice here, I will remove the first one.

Thanks for catching that :)

-- 
viresh
