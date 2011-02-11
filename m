From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Allow pm_runtime_suspend() to succeed
 during system suspend
Date: Fri, 11 Feb 2011 15:36:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102111514180.2048-100000__22531.1674912975$1297456630$gmane$org@iolanthe.rowland.org>
References: <201102112100.23996.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102112100.23996.rjw@sisk.pl>
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
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Feb 2011, Rafael J. Wysocki wrote:

> > The reason why runtime suspend is not allowed during system power transitions
> > if the following race:
> > 
> > - A device has been suspended via a system suspend callback.
> > - The runtime PM framework executes a (scheduled) suspend on that device,
> >   not knowing that it's already been suspended, which potentially results in
> >   accessing the device's registers in a low-power state.
> > 
> > Now, it can be avoided if every driver does the right thing and checks whether
> > the device is already suspended in its runtime suspend callback, but that would
> > kind of defeat the purpose of the runtime PM framework, at least partially.
> 
> In fact, I've just realized that the above race cannot really occur, because
> pm_wq is freezable, so I'm proposing the following change.

Yes, I had reached essentially the same conclusion.  Of course, there 
may still be other kernel threads running or interrupt handlers that 
can interfere.  It's probably okay to assume that drivers will handle 
these things.

> Of course, it still doesn't prevent user space from disabling the runtime PM
> framework's helpers via /sys/devices/.../power/control.

True.  So in the end this won't make much difference, but we might as 
well do it.

Alan Stern
