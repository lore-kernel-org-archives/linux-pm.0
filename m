From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/2] PM / Wakeup: Introduce wakeup source
 objects and event statistics (v3)
Date: Mon, 20 Sep 2010 11:59:08 -0700
Message-ID: <20100920185908.GA29380__10750.5137836144$1285012989$gmane$org@suse.de>
References: <201009201957.40995.rjw@sisk.pl> <201009201959.10070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009201959.10070.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 20, 2010 at 07:59:09PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Wakeup: Introduce wakeup source objects and event statistics (v3)
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

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Nice job!
