From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in
 of_cpumask_init_opp_table()
Date: Thu, 15 Oct 2015 13:05:44 +0530
Message-ID: <20151015073544.GE19018@linux>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

On 14-10-15, 17:52, Thomas Petazzoni wrote:
>  		ret = of_init_opp_table(cpu_dev);
>  		if (ret) {
> -			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
> -			       __func__, cpu, ret);
> -

It should have be modified to pr_debug() at least.

-- 
viresh
