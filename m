From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Mon, 28 Jun 2010 14:50:10 +0200
Message-ID: <201006281450.11285.rjw__49095.6169822768$1277729565$gmane$org@sisk.pl>
References: <201006261514.13491.rjw@sisk.pl> <20100627222804.GA5522@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100627222804.GA5522@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 28, 2010, mark gross wrote:
> Looks good to me!

Great, thanks!  May I add your "Acked-by" to the patch, then?

Rafael


> On Sat, Jun 26, 2010 at 03:14:13PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > One of the arguments during the suspend blockers discussion was that
> > the mainline kernel didn't contain any mechanisms making it possible
> > to avoid losing wakeup events during system suspend.
> > 
> > Generally, there are two problems in that area.  First, if a wakeup
> > event occurs exactly when /sys/power/state is being written to, it
> > may be delivered to user space right before the freezer kicks in, so
> > the user space consumer of the event may not be able to process it
> > before the system is suspended.  Second, if a wakeup event occurs
> > after user space has been frozen, it is not generally guaranteed that
> > the ongoing transition of the system into a sleep state will be
> > aborted.
> > 
> > To address these issues introduce a new global sysfs attribute,
> > /sys/power/wakeup_count, associated with a running counter of wakeup
> > events and three helper functions, pm_stay_awake(), pm_relax(), and
> > pm_wakeup_event(), that may be used by kernel subsystems to control
> > the behavior of this attribute and to request the PM core to abort
> > system transitions into a sleep state already in progress.
> > 
> > The /sys/power/wakeup_count file may be read from or written to by
> > user space.  Reads will always succeed (unless interrupted by a
> > signal) and return the current value of the wakeup events counter.
> > Writes, however, will only succeed if the written number is equal to
> > the current value of the wakeup events counter.  If a write is
> > successful, it will cause the kernel to save the current value of the
> > wakeup events counter and to abort the subsequent system transition
> > into a sleep state if any wakeup events are reported after the write
> > has returned.
> > 
> > [The assumption is that before writing to /sys/power/state user space
> > will first read from /sys/power/wakeup_count.  Next, user space
> > consumers of wakeup events will have a chance to acknowledge or
> > veto the upcoming system transition to a sleep state.  Finally, if
> > the transition is allowed to proceed, /sys/power/wakeup_count will
> > be written to and if that succeeds, /sys/power/state will be written
> > to as well.  Still, if any wakeup events are reported to the PM core
> > by kernel subsystems after that point, the transition will be
> > aborted.]
> > 
> > Additionally, put a wakeup events counter into struct dev_pm_info and
> > make these per-device wakeup event counters available via sysfs,
> > so that it's possible to check the activity of various wakeup event
> > sources within the kernel.
> > 
> > To illustrate how subsystems can use pm_wakeup_event(), make the
> > low-level PCI runtime PM wakeup-handling code use it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
