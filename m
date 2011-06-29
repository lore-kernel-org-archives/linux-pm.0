From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup
	devices during system sleep transitions
Date: Wed, 29 Jun 2011 16:50:35 -0700
Message-ID: <87fwmsnqno.fsf__22900.5928188146$1309391500$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
	<201106252329.24342.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106252329.24342.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 25 Jun 2011 23:29:24 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Devices that are set up to wake up the system from sleep states
> should not be stopped and power should not be removed from them
> when the system goes into a sleep state.  

I don't think this belongs in the generic layer since the two
assumptions above are not generally true on embedded systems, and would
result in rather significant power consumption unnecessarily.

First, whether the device should be stopped on device_may_wakeup():

Some IP blocks (at least on OMAP) have "asynchronous" wakeups.  Meaning
that they can generate wakeups even when they're not clocked (a.k.a
stopped).  So in this case, even after a ->stop_device (which clock
gates the IP), it can still generate wakeups.

Second, whether the device should be powered off if device_may_wakeup():

Embedded SoCs have other ways to wakeup than device-level wakeups.

For example, on OMAP, every pad on the SoC can be configured as a wakeup
source So, for example, you could completely power down the UART IP
blocks (and the enclosing power domain), configure the UART RX pad as a
wakeup source, and still wakeup the system on UART activity.  The OMAP
docs call these IO pad wakeups.

On OMAP in fact, this is the common, default behavior when we enable
"off-mode" in idle and/or suspend, since most of the IPs are powered off
but can still wake up the system.

So in summary, even if device_may_wakeup() is true, many devices (with
additional SoC magic) can still generate wakeups even when stopped and
powered off.

Kevin
