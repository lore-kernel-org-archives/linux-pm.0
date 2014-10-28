From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] kernel: Add support for power-off handler call chain
Date: Tue, 28 Oct 2014 13:04:24 -0700
Message-ID: <20141028200424.GA20617@roeck-us.net>
References: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
 <20141028182312.GA13636@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141028182312.GA13636@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 28, 2014 at 07:23:12PM +0100, Pavel Machek wrote:
> On Tue 2014-10-28 10:11:06, Guenter Roeck wrote:
> > Various drivers implement architecture and/or device specific means to
> > power off the system.  For the most part, those drivers set the global
> > variable pm_power_off to point to a function within the driver.
> > 
> > This mechanism has a number of drawbacks.  Typically only one scheme
> > to remove power is supported (at least if pm_power_off is used).
> > At least in theory there can be multiple means remove power, some of
> > which may be less desirable. For example, some mechanisms may only
> > power off the CPU or the CPU card, while another may power off the
> > entire system.  Others may really just execute a restart sequence
> > or drop into the ROM monitor. Using pm_power_off can also be racy
> > if the function pointer is set from a driver built as module, as the
> > driver may be in the process of being unloaded when pm_power_off is
> > called. If there are multiple power-off handlers in the system, removing
> > a module with such a handler may inadvertently reset the pointer to
> > pm_power_off to NULL, leaving the system with no means to remove power.
> > 
> > Introduce a system power-off handler call chain to solve the described
> > problems.  This call chain is expected to be executed from the architecture
> > specific machine_power_off() function.  Drivers and architeceture code
> > providing system power-off functionality are expected to register with
> > this call chain.  When registering a power-off handler, callers can
> > provide a priority to control power-off handler execution sequence
> > and thus ensure that the power-off handler with the optimal capabilities
> > to remove power for a given system is called first.
> > 
> > Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
Thanks!

Guenter
