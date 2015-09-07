From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Mon, 07 Sep 2015 23:20:01 +0200
Message-ID: <8981266.1iKleIVcUj@vostro.rjw.lan>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51867 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751287AbbIGUwM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 16:52:12 -0400
In-Reply-To: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Octavian Purdila <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday, September 07, 2015 11:42:41 PM Irina Tirdea wrote:
> Add new option to sysfs control interface, allowing the user to force
> suspend the device.

Had we thought this had been a good idea, we'd have added that thing to
the interface from the start.

The problem with it is that user space generally doesn't know when it is
safe to suspend a device, so it cannot force anything into runtime suspend.

> This is useful for devices that need to be
> suspended when closing the lid of a laptop or the screen of a mobile
> device, while userspace still holds open handles to it and the
> system does not enter system suspend.
> 
> Add the "off" option to the sysfs control power interface, along with
> the already present "on" and "auto". When this attribute is set to
> "off", the device will be force suspended by calling its runtime
> suspend callback and disabling runtime power management so that
> further acceses to the device will not change the actual state.

And how is user space supposed to know that it doesn't break things
this way?

> The device can be resumed by setting the attribute to "on" or "auto".
> The behaviour of the interface when switching only between "on"
> and "auto" states remains unchanged.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
> 
> Hi,
> 
> This is a proposal for suspending devices when the closing the lid of
> a laptop or the screen of a mobile device.
> 
> I am testing this with a Goodix touchscreen [1] for an Android mobile
> device. Android has an userspace layer (power HAL) that would normally
> close the touchscreen when the screen is closed. Android touchscreen
> drivers usually provide a custom sysfs interface to allow this.
> This would be better implemented in a common place, to avoid code
> duplication and to simplify the driver code (as previosly discussed
> in [1]).
> 
> I know there are more ways to implement this, so I would appreciate
> your feedback.

So the feedback is that this is not going to work in general.  Please
use a different approach.

Thanks,
Rafael

