From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] acpi-based wakeup event detection
Date: Wed, 19 Aug 2009 12:42:20 +0100
Message-ID: <20090819114220.GA12216@srcf.ucam.org>
References: <1250666661.23178.120.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1250666661.23178.120.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 03:24:21PM +0800, Shaohua Li wrote:

> +	ret = acpi_gpe_pme_check(dev);
> +
> +	acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);

I don't think we want to unconditionally disable the GPE.

> +
> +	acpi_init_gpe_pme();

I'm also not keen on haing the notifier being at the ACPI level. Are we 
guaranteed that the GPE will only be used for wakeups, and will never 
trigger any other sort of notification? Keeping this at the bus level 
may be more practical.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
