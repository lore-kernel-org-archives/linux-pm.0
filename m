From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 2/4] PM / OPP: Rename routines specific to old
 bindings with _v1
Date: Wed, 28 Oct 2015 11:48:11 -0700
Message-ID: <20151028184811.GX19782@codeaurora.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <3d59c93aa8107f96b659dd5e774596c5a396a9d8.1444925400.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3d59c93aa8107f96b659dd5e774596c5a396a9d8.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10/15, Viresh Kumar wrote:
> Clearly distinguish routines based on what version of bindings they
> parse. We have already postfixed routines properly with _v2 for new
> bindings. Postfix the older ones now with _v1.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
