From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 Resend 5/5] PM / OPP: Add debugfs support
Date: Tue, 1 Sep 2015 16:00:44 -0700
Message-ID: <20150901230044.GC21112@codeaurora.org>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <bcca9819c4b8f5fe26bc25d14968463661899f7e.1441083292.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bcca9819c4b8f5fe26bc25d14968463661899f7e.1441083292.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 09/01, Viresh Kumar wrote:
> This patch adds debugfs support to OPP layer to export OPPs and their
> properties for all the devices.
> 
> This creates a top level directory: /sys/kernel/debug/opp and then
> device specific directories (based on device names) inside it. For
> example: 'cpu0', 'cpu1', etc..
> 
> If multiple devices share the OPP table, then the real directory is
> created only for the first device. For all others, links are created to
> the real directory.
> 
> Inside the device specific directory, a separate directory is created
> for each OPP. And within that files per opp property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
