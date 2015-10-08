From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Thu, 08 Oct 2015 22:46:02 +0200
Message-ID: <15556679.oJAEDkJbZ7@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510081512130.1284-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1510081512130.1284-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 08, 2015 03:20:08 PM Alan Stern wrote:
> On Thu, 8 Oct 2015, Grygorii Strashko wrote:
> 
> > >>   /**
> > >> + * device_defer_all_probes() - Enable/disable probing of devices
> > >> + * @enable:  Enable/disable probing of devices
> > >> + *
> > >> + * if @enable = true
> > >> + *	It will disable probing of devices and defer their probes.
> > >> + * otherwise
> > >> + *	It will restore normal behavior and trigger re-probing of deferred
> > >> + *	devices.
> > >> + */
> > >> +void device_defer_all_probes(bool enable)
> > >> +{
> > >> +	defer_all_probes = enable;
> > >> +	if (enable)
> > >> +		/* sync with probes to avoid any races. */
> > >> +		wait_for_device_probe();
> > 
> > ^ pls, pay attention on above code line
> > 
> > >> +	else
> > >> +		driver_deferred_probe_trigger();
> > >> +}
> > > 
> > > Some people might prefer to see two separate functions, an enable
> > > routine and a disable routine.  I don't much care.
> > 
> > May be. Should I change it?
> 
> It would then be more in line with functions like 
> pm_runtime_set_{active|suspended} or pm_runtime_[dont_]use_autosuspend.

Also it would be cleaner code without conditionals:

enable:
	defer_all_probes = true;
	wait_for_device_probe();

disable:
	defer_all_probes = false;
	driver_deferred_probe_trigger();

Cleaner, no?

Thanks,
Rafael
