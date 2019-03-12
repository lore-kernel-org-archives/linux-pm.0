From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / wakeup: Drop wakeup_source_drop()
Date: Tue, 12 Mar 2019 08:55:16 +0530
Message-ID: <20190312032516.dme2wea6zt3v7eiu@vireshk-i7>
References: <2820276.PxaWYKrF8K@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2820276.PxaWYKrF8K@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11-03-19, 12:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit d856f39ac1cc ("PM / wakeup: Rework wakeup source timer
> cancellation") wakeup_source_drop() is a trivial wrapper around
> __pm_relax() and it has no users except for wakeup_source_destroy()
> and wakeup_source_trash() which also has no users, so drop it along
> with the latter and make wakeup_source_destroy() call __pm_relax()
> directly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Commit d856f39ac1cc is in the bleeding-edge branch of the linux-pm.git tree.
> 
> ---
>  drivers/base/power/wakeup.c |   18 +-----------------
>  include/linux/pm_wakeup.h   |    9 ---------
>  2 files changed, 1 insertion(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
