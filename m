From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from
 __pm_runtime_set_status()
Date: Thu, 16 Nov 2017 10:22:41 +0100
Message-ID: <20171116092241.GI11226@localhost>
References: <1713438.irjm9MTSvo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:46291 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdKPJWg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 04:22:36 -0500
Content-Disposition: inline
In-Reply-To: <1713438.irjm9MTSvo@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

On Sun, Nov 12, 2017 at 01:27:30AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The check for "active" children in __pm_runtime_set_status(), when
> trying to set the parent device status to "suspended", doesn't
> really make sense, because in fact it is not invalid to set the
> status of a device with runtime PM disabled to "suspended" in any
> case.  It is invalid to enable runtime PM for a device with its
> status set to "suspended" while its child_count reference counter
> is nonzero, but the check in __pm_runtime_set_status() doesn't
> really cover that situation.
> 
> For this reason, drop the children check from __pm_runtime_set_status()
> and add a check against child_count reference counters of "suspended"
> devices to pm_runtime_enable().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me, but you should also fix
Documentation/power/runtime_pm.txt which was updated to reflect the
constraint that is now being reverted.

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
