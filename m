From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 1/2] PM / Domains: Make
 pm_genpd_{add,remove}_subdomain() available to modules
Date: Tue, 6 Oct 2015 12:32:13 -0700
Message-ID: <20151006193213.GG12338@codeaurora.org>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org>
 <1443727374-1539-2-git-send-email-sboyd@codeaurora.org>
 <6374611.5Nvbqg0Ugs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6374611.5Nvbqg0Ugs@vostro.rjw.lan>
Sender: linux-clk-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10/05, Rafael J. Wysocki wrote:
> On Thursday, October 01, 2015 12:22:53 PM Stephen Boyd wrote:
> >  
> >  /**
> >   * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
> > @@ -1395,6 +1396,7 @@ out:
> >  
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
> >  
> >  /* Default device callbacks for generic PM domains. */
> 
> This is fine by me, please feel free to add my ACK to it.
> 

Thanks. Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
