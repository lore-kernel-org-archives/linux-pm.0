From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/8] ARM: davinci: Sort frequency table
Date: Tue, 7 Jun 2016 15:57:13 +0530
Message-ID: <20160607102713.GD21466@vireshk-i7>
References: <f9a03695c321b9c0628c6ae0136adfe004f358ad.1464931080.git.viresh.kumar@linaro.org>
 <3a395ec9a3cfec21f227a1ad92df237b1dda9f2d.1465184522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a395ec9a3cfec21f227a1ad92df237b1dda9f2d.1465184522.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 06-06-16, 09:14, Viresh Kumar wrote:
> This is required for some of the changes in cpufreq core. There was only
> one function dependent on the order of the table, that is fixed as well.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Fixed an error reported by buildbot, by removing '&' before
>   usage of da850_freq_table.

@Rafael,

If you are going to apply the V4 of the other series that adds new
helpers for sorted freq-tables, then this patch wouldn't be required
anymore. The other 7 shall be applied though.

-- 
viresh
