From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 19:13:56 +0200
Message-ID: <200908141913.56884.rjw__47500.8736750626$1250270137$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908141032070.2987-100000@iolanthe.rowland.org>
	<200908141905.32766.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908141905.32766.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Rafael J. Wysocki wrote:
> On Friday 14 August 2009, Alan Stern wrote:
> > On Thu, 13 Aug 2009, Matthew Garrett wrote:
> > 
> > > On Thu, Aug 13, 2009 at 11:22:44AM -0400, Alan Stern wrote:
...
> > > Though perhaps the device level runtime_idle shouldn't be void - that 
> > > way the bus can ask the driver whether its suspend conditions have been 
> > > satisfied? Right now there doesn't seem to be any way for the bus to ask 
> > > that.
> > 
> > If you want to get the device-level runtime_idle involved, you can make
> > _it_ responsible for scheduling the suspend.  Then the bus-level code
> > simply has to check whether everything is okay at the bus level, and if
> > it is, call the device-level routine.
> > 
> > However changing the return type wouldn't hurt anything, and it would 
> > allow the pm_schedule_suspend call to be centralized in the bus code.  
> > You could ask Rafael about it, or just send him a patch.
> 
> Well, I'm not against that, but what should pm_runtime_idle() do with the
> result returned by it?  Just pass it to the caller?

Hm, perhaps its better to ignore it, though.

Rafael
