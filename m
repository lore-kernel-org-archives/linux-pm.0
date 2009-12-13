From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 13 Dec 2009 14:08:57 +0100
Message-ID: <200912131408.57960.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912121848.33062.rjw@sisk.pl>
	<alpine.LFD.2.00.0912121049390.3526@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912121049390.3526@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 December 2009, Linus Torvalds wrote:
> 
> On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > I'd like to put it into my tree in this form, if you don't mind.
> 
> This version still has a major problem, which is not related to 
> completions vs rwsems, but simply to the fact that you wanted to do this 
> at the generic device layer level rather than do it at the actual 
> low-level suspend/resume level.
> 
> Namely that there's no apparent sane way to say "don't wait for children".

There is, if the partent would really do something that could disturb the
children.  This isn't always the case, but at least in a few important cases
it is (think of a USB controller and USB devices behind it, for example).

I thought we had this discussion already, but perhaps that was with someone
else and in a slightly different context.

The main reasons why I think it's useful to do this at the generic device layer
level are that, if we do it this way:

a. Drivers that don't want to be "asynchronous" don't need to care in any case.

b. Drivers whose suspend and resume routines are guaranteed not to disturb
   anyone else can mark their devices as "async" and be done with it, no other
   modification of the code is needed (drivers that do nothing in their suspend
   and resume routines also fall into this category).

Now, if it's done at the low-level suspend/resume level, a. will not be true
any more in general.  Say device A has parent B and the driver of A wants to
suspend asynchrnously.  It needs to split its suspend into synchronous and
asynchronous part and at one point start an async thread to run the latter.
Now assume B has a real reason not to suspend before the suspens of A has
finished.  Then, the driver of B has to be modified so that it waits for the
A's async suspend to complete (some sort of synchronization between the two
has to be added).  So, even if B is "synchronous", its driver has to be
modified to handle the asynchronous suspend of A.

Similarly, b. will no longer be true if it's done at the low-level
suspend/resume level, because now every driver that wants to be
"asynchronous" will need to take care of running an async thread etc.
Moreover, it will need to make sure that the device parent's driver doesn't
need to be modified, because the parent's suspend may do something that will
disturb the child's asynchronous suspend.  Furthermore, if the parent's driver
doesn't need to be modified, it will need to consider the parent of the parent,
because that one may potentially disturb the asynchronous suspend of its
grand child and so on up to a device without a parent.

That already is a pain to a driver writer, but the problem you're saying would
be solved by doing this at the low-level suspend/resume level is still there
in general!  Namely, go back do the example with devices A and B and say B
_really_ has to wait for A's suspend to complete.  Then, since B is after A in
dpm_list, the PM core will not start the suspend of any device after B until
the suspend of B returns.  Now, if the suspend of B waits for the suspend of
A, then the PM core will effectively wait for the suspend of A to complete
before suspending any other devices.  Worse yet, if that happens, we can't do
anything about it at the low-level suspend/resume level, althouth at the PM
core level we can.

Rafael
