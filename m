From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Thu, 16 Nov 2017 14:57:46 +0100
Message-ID: <2019845.JZoN7saqRp@aspire.rjw.lan>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <20171116092241.GI11226@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171116092241.GI11226@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 16, 2017 10:22:41 AM CET Johan Hovold wrote:
> On Sun, Nov 12, 2017 at 01:27:30AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The check for "active" children in __pm_runtime_set_status(), when
> > trying to set the parent device status to "suspended", doesn't
> > really make sense, because in fact it is not invalid to set the
> > status of a device with runtime PM disabled to "suspended" in any
> > case.  It is invalid to enable runtime PM for a device with its
> > status set to "suspended" while its child_count reference counter
> > is nonzero, but the check in __pm_runtime_set_status() doesn't
> > really cover that situation.
> > 
> > For this reason, drop the children check from __pm_runtime_set_status()
> > and add a check against child_count reference counters of "suspended"
> > devices to pm_runtime_enable().
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Looks good to me, but you should also fix
> Documentation/power/runtime_pm.txt which was updated to reflect the
> constraint that is now being reverted.

Thanks for pointing that out.

> Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks!

Rafael
