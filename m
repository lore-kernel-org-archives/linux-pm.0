From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Thu, 8 Oct 2015 13:24:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510081314400.1502-100000@iolanthe.rowland.org>
References: <1444323427-6822-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50937 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965040AbbJHRYi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 13:24:38 -0400
In-Reply-To: <1444323427-6822-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Thu, 8 Oct 2015, Grygorii Strashko wrote:

> It is unsafe [1] if probing of devices will happen during suspend or
> hibernation and system behavior will be unpredictable in this case.
> So, lets prohibit device's probing in dpm_prepare() and defer their

s/lets/let's/, and same for the comment in the code.

> probing instead. The normal behavior will be restored in
> dpm_complete().


> @@ -172,6 +179,26 @@ static void driver_deferred_probe_trigger(void)
>  }
>  
>  /**
> + * device_defer_all_probes() - Enable/disable probing of devices
> + * @enable:  Enable/disable probing of devices
> + *
> + * if @enable = true
> + *	It will disable probing of devices and defer their probes.
> + * otherwise
> + *	It will restore normal behavior and trigger re-probing of deferred
> + *	devices.
> + */
> +void device_defer_all_probes(bool enable)
> +{
> +	defer_all_probes = enable;
> +	if (enable)
> +		/* sync with probes to avoid any races. */
> +		wait_for_device_probe();
> +	else
> +		driver_deferred_probe_trigger();
> +}

Some people might prefer to see two separate functions, an enable
routine and a disable routine.  I don't much care.

> @@ -277,9 +304,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>  
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
> -	int ret = 0;
> +	int ret = -EPROBE_DEFER;
>  	int local_trigger_count = atomic_read(&deferred_trigger_count);
>  
> +	if (defer_all_probes) {
> +		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
> +		driver_deferred_probe_add(dev);
> +		return ret;
> +	}

In theory there's a race here.  If one CPU sets defer_all_probes, the 
new value might not be perceived by another CPU until a little while 
later.  Is there an easy way to insure that this race won't cause any 
problems?

Or do we already know that when this mechanism gets used, the system is 
already running on a single CPU?  I forget when that happens.

> @@ -1624,6 +1627,16 @@ int dpm_prepare(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
>  	might_sleep();
>  
> +	/* Give a chance for the known devices to complete their probing. */
> +	wait_for_device_probe();
> +	/*
> +	 * It is unsafe if probing of devices will happen during suspend or
> +	 * hibernation and system behavior will be unpredictable in this case.
> +	 * So, lets prohibit device's probing here and defer their probes
> +	 * instead. The normal behavior will be restored in dpm_complete().
> +	 */
> +	device_defer_all_probes(true);

Don't you want to call these two functions in the opposite order?  
First prevent new probes from occurring, then wait for any probes that 
are already in progress?  The way you have it here, a new probe could 
start between these two lines.

Alan Stern

