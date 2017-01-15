From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Calling device_init_wakeup() on driver removal
Date: Sun, 15 Jan 2017 15:49:44 +0100
Message-ID: <3852101.qr97BxrLhj@aspire.rjw.lan>
References: <b4f92201-77f6-4a15-81cf-8f2f384d0c1f@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4f92201-77f6-4a15-81cf-8f2f384d0c1f@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 14, 2017 08:46:05 PM Guenter Roeck wrote:
> Hi folks,

Hi,

> while looking through driver initialization and removal functions, I noticed that many drivers
> call device_init_wakeup(dev, false) in the removal function. Given that the driver is about
> to be removed, that doesn't make much sense to me, especially since device_wakeup_disable()
> is called from device_pm_remove() anyway.
> 
> Is it safe to assume that all those calls can be removed, or is there a possible reason for
> keeping them around ?

Removing them automatically might break things, because device_init_wakeup(dev, false)
also clears the power.can_wakeup flag and removes the "wakeup" attribute from sysfs.

I guess they could be removed safely in the majority of cases, though.

Thanks,
Rafael
