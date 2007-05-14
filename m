From: Alan Stern <stern@rowland.harvard.edu>
Subject: Freezing kernel threads for suspend or hibernation
Date: Mon, 14 May 2007 17:21:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705141702350.13972-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

There are a few threads in the USB core which currently do want to be
frozen.  The reason is simple enough: If left running, they would resume
some suspended devices.  Why?  Because of pending I/O requests or wakeup
requests.

This raises the question: What to do about remote wakeup requests that are
received while a suspend or hibernation is in progress?  Actually that's
two separate questions.

With hibernation, the issue arises only while preparing the memory 
snaphot.  After the snaphot is saved to disk, devices do _not_ get 
suspended before the system is shut down.  Or is that in fact not true?  
Doesn't entering S4 require the OS to put devices in a low-power state?

Anyway, there's no question about what should happen with snapshotting.  
Devices should be quiesced, with no interrupt requests and no remote
wakeup.  Still, what if a request received before the pre_snapshot call is
sitting in a kernel thread's queue?  It's not so easy for the thread to
recognize that it needs to stop processing its queue, because there's no
way to notify it about the upcoming snapshot.

(Furthermore, as a practical matter it's not so easy to do the right thing
for snapshotting, because at the moment the same method call is used for
both snapshot and suspend.  That at least we are going to fix.)


On the other side of the fence, consider suspend.  In principle I don't 
see anything wrong with handling remote wakeup requests while the system 
is trying to suspend.  What should happen is that the device is resumed, 
then the parent should fail to suspend because it has an unsuspended 
child, and the entire system suspend transition should fail.  This is just 
a shortcut for what would happen anyway -- even if the system did manage 
to suspend completely, the pending wakeup request would bring it right 
back up.

The problem to worry about is losing wakeup requests.  This can happen if
a request arrives at the wrong time and the driver isn't careful about
handling it.  For example, maybe the device can't be woken because its
parent is already suspended.  But the request has been acknowledged by the
CPU, so the device won't continue to send more requests.  As a result the
system gets suspended and stays that way.  I think solutions to this
problem must be bus-specific; it's hard to say anything that would hold in
all cases.

Alan Stern
