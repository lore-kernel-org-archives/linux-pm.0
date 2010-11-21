From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt handlers
Date: Mon, 22 Nov 2010 00:45:19 +0100
Message-ID: <201011220045.20059.rjw__33630.2877324217$1290383221$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1011201437450.8483-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011201437450.8483-100000@netrider.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, November 20, 2010, Alan Stern wrote:
> On Sat, 20 Nov 2010, Alan Stern wrote:
> 
> > On Sat, 20 Nov 2010, Rafael J. Wysocki wrote:
> > 
> > > On Friday, November 19, 2010, Alan Stern wrote:
...
> > 
> > I don't think Linus will object to this.  What he doesn't like is when
> > some code drops a lock, reacquires it, and then behaves as though the
> > lock had been held all along.  That's not the case here; rpm_idle()  
> > does not depend on any state remaining unchanged across the callback.
> 
> One other thing I forgot to mention...  If Linus doesn't like the way
> the new code drops the spinlock and then reacquires it, then he must
> also not like the existing code, which does the same thing.  The only
> difference lies in whether or not interrupts are re-enabled.

The problem I have with this change is that switching interrupts off really is
a part of the locking operation, so using spin_unlock() after spin_lock_irq...()
is kind of like releasing the lock partially, which I don't think is valid
(even if we're going to reacquire the lock immediately).

Thanks,
Rafael
