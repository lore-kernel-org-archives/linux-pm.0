From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: QUESTION: How to fix race between .suspend routine
	and watchdog timer
Date: Sat, 27 Oct 2007 15:17:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710271516570.30287-100000__36637.1606164195$1193512748$gmane$org@netrider.rowland.org>
References: <200710261348.42748.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710261348.42748.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Oct 2007, Maxim Levitsky wrote:

> > > Looking through the dmfe code, I noticed yet another possible race.
> > > A race between the .suspend, and a timer that serves both as a watchdog, and link state detector.
> > > Again I need to prevent it from running during the suspend/resume, but how?
> > > 
> > > I can use del_timer in .suspend, and mod_timer in .resume, but that doesn't protect against
> > > race with already running timer.
> > > I can use del_timer_sync, but it states that it is useless if timer re-enables itself, and I agree with that.
> > > In dmfe case the timer does re-enable itself.
> > 
> > That comment isn't right.  del_timer_sync works perfectly well even if
> > the timer routine re-enables itself, provided it stops doing so after a
> > small number of iterations.
> Thanks for the info. but....
> Due to the "don't access the hardware, while powered-off" rule, I must know that the timer isn't running.
> and won't be.
> So what function to use (if possible) to be sure that the timer won't run anymore?
> (Taking in the account the fact that it re-enables itself)

Use del_timer_sync().  It guarantees that when it returns, the timer 
will be stopped and the timer routine will no longer be running on any 
CPU.

Alan Stern
