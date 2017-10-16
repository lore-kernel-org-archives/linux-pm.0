From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver
 flags
Date: Mon, 16 Oct 2017 08:28:52 +0200
Message-ID: <20171016062852.GA28732@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1998650.Q52BuGQTI4@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
>  struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned int		can_wakeup:1;
> @@ -561,6 +580,7 @@ struct dev_pm_info {
>  	bool			is_late_suspended:1;
>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
> +	unsigned int		driver_flags;

Minor nit, u32 or u64?

thanks,

greg k-h
