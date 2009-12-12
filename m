From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System sleep vs. runtime PM
Date: Sat, 12 Dec 2009 23:45:35 +0100
Message-ID: <200912122345.35288.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912121411230.12891-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912121411230.12891-100000@netrider.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 December 2009, Alan Stern wrote:
> On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> 
> > > Also, when the system resume is finished, drivers need a chance to 
> > > runtime-suspend again.  Hence the pm_runtime_put_noidle() call in 
> > > dpm_complete() should be changed to pm_runtime_put_sync().
> > 
> > OK
> > 
> > Are you going to send a patch or do you want me to prepare one?
> 
> We're talking about mostly documentation changes, right?  I can write 
> them.

OK

> But the code changes will present a small problem.  I'll need them for
> the USB development.  Will it be okay to ask Greg KH to put them in his
> tree after you have accepted them into yours?  That will avoid
> cross-subsystem build errors.  (We just got through one of them 
> involving David Miller and I'd rather avoid any more.)

I'm fine with that.

> There's one other thing (should have brought it up earlier): Do you
> mind having the runtime-PM callbacks invoke the bus type or the bus

I guess you mean device type and device class?

> class methods instead of the bus methods, if they are defined?  That
> is, do them in the same way the system-PM callbacks work.  The USB code
> will definitely want different methods for the different types.  In 
> fact, I've already written a version that tests the bus type within the 
> callback routines.

That's a good question.  I didn't anticipate that, so it's hard to tell right
now.  I don't really see any fundamental obstacles now, though.

Rafael
