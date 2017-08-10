From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ACPI / Sleep: Check low power idle constraints
 for debug only
Date: Thu, 10 Aug 2017 15:54:12 -0700
Message-ID: <1502405652.20268.20.camel@linux.intel.com>
References: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1502232075-23832-3-git-send-email-srinivas.pandruvada@linux.intel.com>
         <146e121b5db84fb8a8aa692cee01cb7b@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <146e121b5db84fb8a8aa692cee01cb7b@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-08-10 at 22:07 +0000, Mario.Limonciello@dell.com wrote:
> 
> > 
> > 
[...]

> > +
> > +		ret = acpi_device_get_power(adev, &state);
> > +		if (!ret)
> > +			pr_debug("LPI: %s required min power state
> > %d, current
> > power state %d, real power state %d\n",
> > +				 lpi_constraints_table[i].name,
> > +				 lpi_constraints_table[i].min_dsta
> > te,
> > +				 adev->power.state, state);
> Isn't this superfluous to be showing the state returned from
> acpi_device_get_power and
> also probing directly at the state? You can't just rely on the
> information you got
> back from apci_device_get_power?
They can be different as one is real power state and the other is what
was set.
For example on Dell 9365 it shows

[ 1924.393653] LPI: \_SB.PCI0.XHC required min power state 3, current
power state 3, real power state 255 

> 
> > 
> > +
> > +		if (adev->flags.power_manageable && adev-
> > >power.state <
> > +					lpi_constraints_table[i].m
> > in_dstate)
> > +			pr_info("LPI: Constraint [%s] not
> > matched\n",
> > +				 lpi_constraints_table[i].name);
> Similarly here, can't you just compare against &state instead?
> 
The problem then the check will fail for XHCI on Dell 9365. So not
using "state".

Thanks,
Srinivas
> > 
> > +	}
> > +}
> > +
> >  static void acpi_sleep_run_lps0_dsm(unsigned int func)
> >  {
> >  	union acpi_object *out_obj;
> > @@ -729,6 +886,9 @@ static int lps0_device_attach(struct
> > acpi_device *adev,
> >  				  "_DSM function 0 evaluation
> > failed\n");
> >  	}
> >  	ACPI_FREE(out_obj);
> > +
> > +	lpi_device_get_constraints();
> > +
> >  	return 0;
> >  }
> > 
> > @@ -773,6 +933,8 @@ static void acpi_freeze_wake(void)
> >  	 */
> >  	if (acpi_sci_irq_valid() &&
> >  	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
> > {
> > +		if (pm_debug_messages_enabled())
> > +			lpi_check_constraints();
> >  		pm_system_cancel_wakeup();
> >  		s2idle_wakeup = true;
> >  	}
> > --
> > 2.7.5
