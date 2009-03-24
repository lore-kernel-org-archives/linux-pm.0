From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: avoid PM error messages during resume
 if a device was disconnected
Date: Tue, 24 Mar 2009 10:11:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0903241004160.3162-100000__12269.4507860162$1237904158$gmane$org@iolanthe.rowland.org>
References: <200903232325.04181.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903232325.04181.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Mar 2009, Frans Pop wrote:

> > Or do you think maybe it would be better to move this test up into the
> > PM core?  After all, other subsystems will face the same issue.  I
> > think that would be the best approach.  Yes?
> 
> I did look at that option, but implementing it in the USB subsystem seemed
> more logical to me, for example as other subsystems possibly would want to
> display an info message.

They still can...

> And is -ENODEV safe to ignore in all cases? Would there be other errors that
> should be ignored too?

In general, the PM core ignores _all_ errors during resume -- in the
sense that it doesn't try to recover from them or do anything to handle
them.  All it does is put a message in the log.

So your question becomes: For which errors should a message be added to 
the system log?  The most logical answer seems to be that we want an 
error message whenever something bad or unexpected occurs.

Removal of a hot-unpluggable device isn't really bad or unexpected.  
Removal of a non-hot-unpluggable device might be bad, but on the other
hand the system isn't really "hot" while it is suspended.  Besides, the
appropriate subsystem can print an error message.  Furthermore the
kernel can't easily tell which devices are hot-unpluggable and which
aren't.

Anything else amounts to failure resuming a device that still exists.  
As such, it probably deserves an error message.

> if Rafael would be happy with a generic test for -ENODEV, it could be done.
> If not, maybe some other special error code would need to be used but then
> you'd still need to test in the subsystem to set that error.
> Disadvantage is also that it would make resume_device() and related PM
> driver core functions quite a bit less clean than they currently are.
> 
> Implementing the test in USB was quite a bit simpler (for me at least ;-)

We should get Rafael's opinion.

Alan Stern
