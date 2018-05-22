From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] PM / core: Fix direct_complete handling for devices with
 no callbacks
Date: Tue, 22 May 2018 14:37:10 +0200
Message-ID: <20180522123710.GV30172@localhost>
References: <6238546.EnOBWIOf9o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6238546.EnOBWIOf9o@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Martitz <kugel@rockbox.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 22, 2018 at 01:02:17PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE
> driver flags) inadvertently prevented the power.direct_complete flag
> from being set for devices without PM callbacks and with disabled
> runtime PM which also prevents power.direct_complete from being set
> for their parents.  That led to problems including a resume crash on
> HP ZBook 14u.
> 
> Restore the previous behavior by causing power.direct_complete to be
> set for those devices again, but do that in a more direct way to
> avoid overlooking that case in the future.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags)

I stumbled over this the other day as well and tracked it down to the
above commit. In my case (child devices to serdev clients), this was
mostly benign although it did prevent the direct-complete optimisation
during suspend.

Never got around to reporting or fixing it myself, but your analysis and
fix matches my initial findings.

> Reported-by: Thomas Martitz <kugel@rockbox.org>
> Tested-by: Thomas Martitz <kugel@rockbox.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

As already suggested elsewhere in the thread, I think a stable is
warranted too.

Thanks,
Johan
