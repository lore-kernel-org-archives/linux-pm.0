From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/4] PM / OPP: Improve debug print messages with pr_fmt
Date: Fri, 16 Oct 2015 11:07:13 +0530
Message-ID: <20151016053713.GO19018@linux>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <d3072ab1f6665e63d2e26db75a3d598b241d423e.1444925400.git.viresh.kumar@linaro.org>
 <20151015190421.GK4558@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151015190421.GK4558@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 15-10-15, 12:04, Stephen Boyd wrote:
> On 10/15, Viresh Kumar wrote:
> > With debug options on, it is difficult to locate OPP core's debug
> > prints. Fix this by prefixing OPP debug prints with KBUILD_MODNAME.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Why not use dynamic debug's m flag to turn on KBUILD_MODNAME when
> debugging?
> 
> >From Documentation/dynamic-debug-howto.txt
> 
>   m    Include module name in the printed message

It wasn't just about debug messages but pr_info and pr_err as well.
And so I defined pr_fmt instead.

-- 
viresh
