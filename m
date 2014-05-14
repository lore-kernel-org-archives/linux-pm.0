From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/3] PM / sleep: Mechanism to avoid resuming
 runtime-suspended devices unnecessarily
Date: Wed, 14 May 2014 10:53:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405141041360.1432-100000@iolanthe.rowland.org>
References: <16671603.abrivY8Odm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <16671603.abrivY8Odm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 May 2014, Rafael J. Wysocki wrote:

> > It would be surprising if ->prepare() needed to make any difficult
> > checks.  This would imply that the device could have multiple
> > runtime-suspend states, some of which are appropriate for system
> > suspend while others aren't.  Not impossible, but I wouldn't expect it
> > to come up often.
> 
> That is the case for every device with ACPI power management in principle. :-)
> 
> Please see patch [3/3] for details.

I don't understand enough about the ACPI subsystem to follow the
details of that patch.

> OK, I've updated the $subject patch in the meantime and the result is appended
> Former patch [1/3] is not necessary any more now and patch [3/3] is still valid.
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily
> 
> Currently, some subsystems (e.g. PCI and the ACPI PM domain) have to
> resume all runtime-suspended devices during system suspend, mostly
> because those devices may need to be reprogrammed due to different
> wakeup settings for system sleep and for runtime PM.

...

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This is looking quite good.  I have one suggestion for a small 
improvement...

> @@ -1332,6 +1338,16 @@ static int __device_suspend(struct devic
>  	if (dev->power.syscore)
>  		goto Complete;
>  
> +	if (dev->power.direct_complete) {
> +		pm_runtime_disable(dev);
> +		if (dev->power.disable_depth == 1
> +		    && pm_runtime_status_suspended(dev))
> +			goto Complete;
> +
> +		dev->power.direct_complete = false;
> +		pm_runtime_enable(dev);
> +	}

Do we want to allow ->prepare() to return > 0 if the device isn't
runtime suspended?  If we do then non-suspended devices may be a common
case.  We should then avoid the extra overhead of disable + enable.  
So I would write:

	if (dev->power.direct_complete) {
		if (pm_runtime_status_suspended(dev)) {
			pm_runtime_disable(dev);
			if (dev->power.disable_depth == 1
			    && pm_runtime_status_suspended(dev))
				goto Complete;
			pm_runtime_enable(dev);
		}
		dev->power.direct_complete = false;
	}

Also, now that we have finally settled on the appropriate API, there
needs to ba a patch updating the PM documentation.

Alan Stern

