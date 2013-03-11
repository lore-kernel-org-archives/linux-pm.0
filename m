From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] kirkwood: fix coccicheck warnings
Date: Mon, 11 Mar 2013 09:46:21 -0400
Message-ID: <20130311134621.GA23237@titan.lakedaemon.net>
References: <1362987319-6369-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362987319-6369-1-git-send-email-silviupopescu1990@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: cpufreq@vger.kernel.org, rjw@sisk.pl, rui.zhang@intel.com, andrew@lunn.ch, rob.lee@linaro.org, len.brown@intel.com, khilman@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 11, 2013 at 09:35:19AM +0200, Silviu-Mihai Popescu wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  drivers/cpufreq/kirkwood-cpufreq.c |    8 +++-----
>  drivers/cpuidle/cpuidle-kirkwood.c |    6 +++---
>  drivers/thermal/kirkwood_thermal.c |    8 +++-----
>  3 files changed, 9 insertions(+), 13 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
