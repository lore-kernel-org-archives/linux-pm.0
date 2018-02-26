From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCHv2] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Mon, 26 Feb 2018 23:55:16 +0200
Message-ID: <1519682116.10722.206.camel@linux.intel.com>
References: <20180223220612.35181-1-tony@atomide.com>
         <1519565632.10722.150.camel@linux.intel.com>
         <20180226215102.GG16043@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226215102.GG16043@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-02-26 at 13:51 -0800, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180225 13:37]:
> > On Fri, 2018-02-23 at 14:06 -0800, Tony Lindgren wrote:
> > > 


> +	wirq->name = kasprintf(GFP_KERNEL, "%s:wakeup",
> +			       dev_name(dev));

Can it make one line?

In any case,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
