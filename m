From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: QUESTION: How to fix race between .suspend routine and
	watchdog timer
Date: Fri, 26 Oct 2007 13:48:42 +0200
Message-ID: <200710261348.42748.maximlevitsky__26439.7640167319$1193399451$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0710251259230.7029-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710251259230.7029-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 October 2007 19:02:12 Alan Stern wrote:
> On Thu, 25 Oct 2007, Maxim Levitsky wrote:
> 
> > Hi,
> > 
> > Recently, trying to fix saa7134 suspend/resume problems I found that there 
> > is a race between IRQ handler and .suspend , and that I cant let driver access the device
> > while its in D3 since it can lock up some systems.
> > 
> > Now I am looking to fix those issues in two drivers that have my .suspend/.resume routines.
> > the saa7134 capture chip and dmfe, the davicom network driver.
> > 
> > Looking through the dmfe code, I noticed yet another possible race.
> > A race between the .suspend, and a timer that serves both as a watchdog, and link state detector.
> > Again I need to prevent it from running during the suspend/resume, but how?
> > 
> > I can use del_timer in .suspend, and mod_timer in .resume, but that doesn't protect against
> > race with already running timer.
> > I can use del_timer_sync, but it states that it is useless if timer re-enables itself, and I agree with that.
> > In dmfe case the timer does re-enable itself.
> 
> That comment isn't right.  del_timer_sync works perfectly well even if
> the timer routine re-enables itself, provided it stops doing so after a
> small number of iterations.
Thanks for the info. but....
Due to the "don't access the hardware, while powered-off" rule, I must know that the timer isn't running.
and won't be.
So what function to use (if possible) to be sure that the timer won't run anymore?
(Taking in the account the fact that it re-enables itself)
> 
> > I can put checks in the timer for ->insuspend, and don't re enable it if set,
> > but that opens a new can of worms with memory barriers, etc...
> 
> You don't have to worry about any of that stuff.  Just check the 
> insuspend flag and don't re-enable the timer if it is set.  Even 
> without any memory barriers, the timer routine won't iterate more than 
> once or twice.
> 
> Alan Stern
> 
> 

Thanks,
	Best regards,
	`	Maxim Levitsky
