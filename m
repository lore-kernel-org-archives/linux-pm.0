From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/11] PM: Enable early suspend
	through	/sys/power/state
Date: Mon, 2 Feb 2009 12:44:01 +0100
Message-ID: <20090202114400.GA4631@elf.ucw.cz>
References: <d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
	<Pine.LNX.4.44L0.0901311047280.6305-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0901311047280.6305-100000@netrider.rowland.org>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2009-01-31 10:49:16, Alan Stern wrote:
> On Fri, 30 Jan 2009, Arve Hj?nnev?g wrote:
> 
> > > No, please don't break compatibility like this. You changed semantics
> > > of 'mem'...
> > >
> > > Just add another two states, for example "auto-mem" and
> > > "auto-standby", and make them enter mem/standby when required.
> > >
> > 
> > What would you want to happen if someone writes "mem"? If we just call
> > enter_state, it will fail and return an error if a wakelock is locked.
> > We can call request_suspend_state and then wait for another thread to
> > write "on", but this still requires user-space changes to work
> > correctly. If the goal is to allow the kernel to be compiled with
> > wakelock and early suspend support while preserving the old behaviour
> > if wakelocks are not used, then the first option is better.
> 
> This is exactly what I am complaining about in another thread.  The 
> code should be written so that when the user writes "mem", the system 
> goes into suspend even if some wakelocks are locked.

Yes please.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
