From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM / Wakeup: Introduce wakeup source objects and
	event statistics (v2)
Date: Thu, 16 Sep 2010 17:41:14 -0700
Message-ID: <87eict5hhx.fsf__35540.8733514652$1284684137$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1009101119060.1651-100000@iolanthe.rowland.org>
	<201009110029.31843.rjw@sisk.pl> <201009150031.36070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009150031.36070.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 15 Sep 2010 00:31:35 +0200")
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arve@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Wakeup: Introduce wakeup source objects and event statistics (v2)
>
> Introduce struct wakeup_source for representing system wakeup sources
> within the kernel and for collecting statistics related to them.
> Make the recently introduced helper functions pm_wakeup_event(),
> pm_stay_awake() and pm_relax() use struct wakeup_source objects
> internally, so that wakeup statistics associated with wakeup devices
> can be collected and reported in a consistent way (the definition of
> pm_relax() is changed, which is harmless, because this function is
> not called directly by anyone yet).  Introduce new wakeup-related
> sysfs device attributes in /sys/devices/.../power for reporting the
> device wakeup statistics.
>
> Change the global wakeup events counters event_count and
> events_in_progress into atomic variables, so that it is not necessary
> to acquire a global spinlock in pm_wakeup_event(), pm_stay_awake()
> and pm_relax(), which should allow us to avoid lock contention in
> these functions on SMP systems with many wakeup devices.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Hi Rafael,

This looks like a really useful feature.  Was doing some experiments
with this on OMAP, and found a minor cut-and-paste bug in the
Documentation file:

[...]

> +What:		/sys/devices/.../power/wakeup_max_time_ms
> +Date:		September 2010
> +Contact:	Rafael J. Wysocki <rjw@sisk.pl>
> +Description:
> +		The /sys/devices/.../wakeup_max_time_ms attribute contains
> +		the maximum time of processing a single wakeup event associated
> +		with the device, in milliseconds.  This attribute is read-only.
> +		If the device is not enabled to wake up the system from sleep
> +		states, this attribute is empty.
> +
> +What:		/sys/devices/.../power/wakeup_max_time_ms
                                                      ^^^
s/max/last/ for this one.

> +Date:		September 2010
> +Contact:	Rafael J. Wysocki <rjw@sisk.pl>
> +Description:
> +		The /sys/devices/.../wakeup_last_time_ms attribute contains
> +		the value of the monotonic clock corresponding to the time of
> +		signaling the last wakeup event associated with the device, in
> +		milliseconds.  This attribute is read-only.  If the device is
> +		not enabled to wake up the system from sleep states, this
> +		attribute is empty.

Kevin
