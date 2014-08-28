From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: cpu0: Removes unnecessary IS_ERR check on
 clk
Date: Thu, 28 Aug 2014 13:31:03 +0800
Message-ID: <20140828053102.GC23836@dragon>
References: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
 <1409209212-18730-2-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409209212-18730-2-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 28, 2014 at 12:00:11AM -0700, Pramod Gurav wrote:
> This removes unnecessary IS_ERR check on clk when in failure path
> as execution wont reach till there with clk being a err.
> 
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
