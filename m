From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
 before hibernation/suspend
Date: Mon, 28 May 2007 12:09:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705281156470.22682-100000@netrider.rowland.org>
References: <20070527220158.GB22687@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070527220158.GB22687@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 May 2007, Matthew Garrett wrote:

> > BTW, I know of two subsystems that want their kernel threads to be frozen for
> > synchronization purposes.  Please see these messages:
> > 
> > 1) https://lists.linux-foundation.org/pipermail/linux-pm/2007-May/012592.html
> > (plus follow up)
> > 
> > 2) http://marc.info/?l=linux-kernel&m=117919066830575&w=2
> 
> I'm not entirely sold on this. The issue is that there's the possibility 
> of races during suspend/resume? It sounds like that should be 
> implemented in the driver, rather than depending on a side-effect of 
> process freezing. Otherwise there's no way of selectively suspending 
> that device.

I can't speak for the second example, but there's a good reason the
first example works this way.  It's not a matter of races; the problem
is that the kernel thread's job is to selectively suspend and resume
devices.  We don't want it doing this while a system sleep is in 
progress; it would (and in fact has, before the thread was made 
freezable) cause the sleep transition to abort.

Handling it entirely from within the drivers is possible in theory.  
Unfortunately the design of the PM core has not leant itself to such an 
approach.  Using separate callbacks for hibernation vs. STR will help, 
as will Raphael's notifiers.

Alan Stern
