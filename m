From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC][PATCH 2/3] PM / sleep: Mechanism to avoid resuming
 runtime-suspended devices unnecessarily
Date: Tue, 13 May 2014 11:30:52 +0200
Message-ID: <CAPDyKFowGvzeD807ViaHy=01OE-E0nVy=YJbVmau4ZNRe-qJ9g@mail.gmail.com>
References: <4649019.is79p6EySp@vostro.rjw.lan>
	<1752814.FckPkBGaUc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1752814.FckPkBGaUc@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13 May 2014 03:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Currently, some subsystems (e.g. PCI and the ACPI PM domain) have to
> resume all runtime-suspended devices during system suspend, mostly
> because those devices may need to be reprogrammed due to different
> wakeup settings for system sleep and for runtime PM.
>
> For some devices, though, it's OK to remain in runtime suspend
> throughout a complete system suspend/resume cycle (if the device was in
> runtime suspend at the start of the cycle).  We would like to do this
> whenever possible, to avoid the overhead of extra power-up and power-down
> events.
>
> However, problems may arise because the device's descendants may require
> it to be at full power at various points during the cycle.  Therefore the
> most straightforward way to do this safely is if the device and all its
> descendants can remain runtime suspended until the complete stage of
> system resume.
>
> To this end, introduce a new device PM flag, power.direct_complete
> and modify the PM core to use that flag as follows.
>
> If the ->prepare() callback of a device returns a positive number,
> the PM core will regard that as an indication that it may leave the
> device runtime-suspended.  It will then check if the system power
> transition in progress is a suspend (and not hibernation in particular)
> and if the device is, indeed, runtime-suspended.  In that case, the PM
> core will set the device's power.direct_complete flag.  Otherwise it
> will clear power.direct_complete for the device and it also will later
> clear it for the device's parent (if there's one).
>
> Next, the PM core will not invoke the ->suspend() ->suspend_late(),
> ->suspend_irq(), ->resume_irq(), ->resume_early(), or ->resume()
> callbacks for all devices having power.direct_complete set.  It
> will invoke their ->complete() callbacks, however, and those
> callbacks are then responsible for resuming the devices as
> appropriate, if necessary.
>
> Changelog partly based on an Alan Stern's description of the idea
> (http://marc.info/?l=linux-pm&m=139940466625569&w=2).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I like this idea! And we don't need to add new functions to the runtime PM API.

[snip]

> -
> -       return error;
> +               return ret;
> +       }
> +       dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND
> +                                       && pm_runtime_suspended(dev);

This might deserve a comment!?

> +       return 0;
>  }
>
>  /**
>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
