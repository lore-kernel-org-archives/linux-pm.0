From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 6)
Date: Wed, 02 Apr 2008 06:34:27 +1100
Message-ID: <1207078467.23143.96.camel__11734.0604927906$1207078552$gmane$org@nigel-laptop>
References: <Pine.LNX.4.44L0.0804011029010.3993-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0804011029010.3993-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2008-04-01 at 10:31 -0400, Alan Stern wrote:
> On Tue, 1 Apr 2008, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2008-04-01 at 19:15 +1100, Nigel Cunningham wrote:
> > > > + *   However, drivers may NOT assume anything about the availability of the
> > > > + *   user space at that time and it is not correct to request firmware from
> > > > + *   within @prepare() (it's too late to do that).
> > > 
> > > That doesn't sound good. It would be good to be able to get drivers to
> > > request firmware early in the process.
> > 
> > Agreed. Prepare() should still allow request_firmware and full userspace
> > communication / helper usage.
> 
> Pepare() is called after userspace has been frozen.  (Of course, once 
> the freezer goes away this won't matter any more.)
> 
> There is a separate notifier chain which drivers can subscribe to;
> notifications about impending sleeps are sent out while userspace is
> still alive.  Drivers can use that for request_firmware, memory
> allocation, and other things.

Then that should be mentioned here so that drivers authors can know that
it is possible to request firmware, allocate memory and so on at a stage
when you can still rely on userspace being alive.

Regards,

Nigel
