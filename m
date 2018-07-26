From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 hibernation
Date: Thu, 26 Jul 2018 12:59:25 +0300
Message-ID: <20180726095925.GU2534@lahna.fi.intel.com>
References: <1645662.bYMTJFObNO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1645662.bYMTJFObNO@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 26, 2018 at 10:58:20AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and
> resume from S3) modified the ACPI driver for Intel SoCs (LPSS) to
> avoid applying PM quirks on suspend and resume from S3 to address
> system-wide suspend and resume problems on some systems, but it is
> reported that the same issue also affects hibernation, so extend
> the approach used by that commit to cover hibernation as well.
> 
> Fixes: a09c59130688 (ACPI / LPSS: Avoid PM quirks on suspend and resume from S3)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
