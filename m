From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 13:55:45 +0100
Message-ID: <200912201355.45760.rjw__9324.98987899653$1261313839$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912192232360.6618-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912192232360.6618-100000@netrider.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 December 2009, Alan Stern wrote:
> On Sat, 19 Dec 2009, Rafael J. Wysocki wrote:
> 
> > On Friday 18 December 2009, Alan Stern wrote:
> > > On Fri, 18 Dec 2009, Rafael J. Wysocki wrote:
> > > 
> > > > I didn't manage to do that, but I was able to mark sd and i8042 as async and
> > > > see the impact of this.
> > > 
> > > Apparently this didn't do what you wanted.  In the nx6325
> > > sd+i8042+async+extra log, the 0:0:0:0 device (which is a SCSI disk) was
> 
> To be precise, the device is an ATA or SATA disk but it is managed by 
> the sd driver.
> 
> > > suspended by the main thread instead of an async thread.
> > 
> > Hm, that's odd, because there's a noticeable time difference between the
> > two cases in which the sd is sync and async.  I'll look into it further.
> 
> I don't know what the whole story is, but the PID number tells the 
> tale.
> 
> > > There's an important point I neglected to mention before.  Your logs 
> > > don't show anything for devices with no suspend callbacks at all.  
> > > Nevertheless, these devices sit on the device list and prevent other
> > > devices from suspending or resuming as soon as they could.
> > 
> > Unless they are async, that is.
> 
> Yes.  It would be simpler to make them async.  But first we ought to
> know what they are.  Can you add an extra line to the log for such
> devices?

Sure, I'll do that.

> What I'm afraid of is that there might be a "normal" device with a
> "normal" ancestor but with "abnormal" devices in between (where
> "normal" means there is a suspend or resume routine and "abnormal"  
> means all the method pointers are NULL).  I know that this happens when
> there's a USB mass-storage device, for example.  If we complete the
> intermediate devices immediately, then there won't be anything to
> prevent the ancestor from suspending before the device or the device
> from resuming before the ancestor.

I'm afraid of that too.

Rafael
