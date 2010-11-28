From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
	errors unnecessarily
Date: Sun, 28 Nov 2010 23:52:10 +0100
Message-ID: <201011282352.10498.rjw__35049.4056278423$1290984875$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1011281031240.27303-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011281031240.27303-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, November 28, 2010, Alan Stern wrote:
> On Sun, 28 Nov 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Currently dpm_prepare() returns error code if it finds that a device
> > being suspended has a pending runtime resume request.  However, it
> > should not do that if the checking for wakeup events is not enabled.
> 
> It doesn't.  The line you changed _does_ check device_may_wakeup().

That's not the point.  The problem is that it shouldn't abort suspend
when events_check_enabled is unset.

> > On the other hand, if the checking for wakeup events is enabled, it
> > can return error when a wakeup event is detected, regardless of its
> > source.
> 
> Will adding this call to pm_wakeup_event() end up double-counting some 
> events?

Yes, it will, if the event has already been reported by the subsystem or driver.

I don't think it's a very big issue and I'm not sure trying to avoid it is
worth the effort (we can check if the device's wakeup source object is active
and skip reporting the wakeup event in that case, but that doesn't guarantee
that the event won't be counted twice anyway).

Thanks,
Rafael
