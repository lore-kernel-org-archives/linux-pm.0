From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Tue, 10 Jul 2012 14:47:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207101437230.1308-100000@iolanthe.rowland.org>
References: <201207102031.15579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207102031.15579.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Jul 2012, Rafael J. Wysocki wrote:

> > > Anyway, you can't force the device into a low-power state using
> > > runtime PM after a failing probe, at least in general.
> > 
> > Well, using PM domains, that's exactly what can happen if the driver
> > doesn't call pm_runtime_disable() because the _put_sync() in the driver
> > core will trigger the PM domain callbacks.
> 
> OK, so if you have PM domains, then the case is equivalent to having a bus
> type with its own runtime PM callbacks.  In that case, if .probe() fails,
> it obviously doesn't mean that the device shouldn't be power managed,
> so the driver shouldn't call pm_runtime_disable().
> 
> Generally, if runtime PM was enabled for a device before .probe() has been
> called, the driver shouldn't disable it in .probe() whatever the reason,
> because it may not have enough information for deciding whether or not
> runtime PM should be disabled.

So if the PM domain code called pm_runtime_enable() then the domain
code should be responsible for calling pm_runtime_disable() too, 
presumably after putting the device back into a low-power state.  I'm 
not sure when that would occur, however.  Immediately after registering 
the device, if no driver is bound?

In the case where the probe routine called pm_runtime_enable(), you're
stuck.  The probe routine _has_ to call pm_runtime_disable() when a
failure occurs, to keep the disable count balanced.

Alan Stern
