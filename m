From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
Date: Fri, 13 Oct 2017 13:22:32 +0300
Message-ID: <20171013102231.GZ2761@lahna.fi.intel.com>
References: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 13, 2017 at 02:35:12AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PM QoS flag PM_QOS_FLAG_REMOTE_WAKEUP is not used consistently
> and the vast majority of code simply assumes that remote wakeup
> should be enabled for devices in runtime suspend if they can
> generate wakeup signals, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
