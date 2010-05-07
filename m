From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 19:20:24 -0700
Message-ID: <20100507022024.GI30928__9892.80203725702$1273198891$gmane$org@atomide.com>
References: <20100506183335.GE30928@atomide.com>
	<Pine.LNX.4.44L0.1005061440370.1708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005061440370.1708-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [100506 11:42]:
> On Thu, 6 May 2010, Tony Lindgren wrote:
> 
> > Well if your hardware runs off-while-idle or even just
> > retention-while-idle, then the basic shell works just fine waking up
> > every few seconds or so.
> > 
> > Then you could keep init/shell/suspend policy deamon running until
> > it's time to suspend the whole device. To cut down runaway timers,
> > you could already freeze the desktop/GUI/whatever earlier.
> 
> This comes down mostly to efficiency.  Although the suspend blocker
> patch does the actual suspending in a workqueue thread, AFAIK there's
> no reason it couldn't use a user thread instead.
> 
> The important difference lies in what happens when a suspend fails
> because a driver is busy.  Without suspend blockers, the kernel has to
> go through the whole procedure of freezing userspace and kernel threads
> and then suspending a bunch of drivers before hitting the one that's
> busy.  Then all that work has to be undone.  By contrast, with suspend
> blockers the suspend attempt can fail right away with minimal overhead.

But does that really matter if you're only few tens of times times per
day or so? I don't understand why you would want to try to suspend except
after some timeout of no user or network activity.
 
> There's also a question of reliability.  With suspends controlled by 
> userspace there is a possibility of races, which could lead the system 
> to suspend when it shouldn't.  With control in the kernel, these races 
> can be eliminated.

I agree the suspend needs to happen without races. But I think the
logic for when to suspend should be done in the userspace as it
can be device or user specific.

Regards,

Tony
