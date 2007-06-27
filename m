From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/8][bugfix] PM: Introduce
	set_target method in pm_ops
Date: Wed, 27 Jun 2007 22:27:54 +0200
Message-ID: <200706272227.55983.rjw__12758.2798748792$1182975674$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
	<200706260041.20561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706260041.20561.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 26 June 2007 00:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The at91 platform code incorrectly assumes that pm_ops->prepare() will be called
> before devices are suspended and uses it to make the PM core set the target
> system sleep state used by the platform when suspending devices.  Thus, at91
> needs a new member function in 'struct pm_ops' that will be used by the PM core
> to convey the target system sleep state to the platform code before devices are
> suspended.
> 
> Moreover, in the future some drivers may need to use ACPI to determine the low
> power states in which to place their devices, but to provide the drivers with
> this information the ACPI core needs to know what sleep state the system is
> going to enter.  Namely, the device's state should not be too high power for
> given system sleep state and, if the device is supposed to be able to wake up
> the system, its state should not be too low power for the wake up to be
> possible).  However, pm_ops->prepare() is only called after the drivers'
> .suspend() callbacks have been executed, so we need an additional means to
> convey the target system sleep state to the ACPI core.  The new member function
> in 'struct pm_ops', set_target(), can be used for this purpose.

If there are no objections to this patch, I'd like to push it for merging into
2.6.22, because at91 suspend will be broken without it.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
