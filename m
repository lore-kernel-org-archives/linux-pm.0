From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 11:33:35 -0700
Message-ID: <20100506183335.GE30928__24053.9730330513$1273170892$gmane$org@atomide.com>
References: <Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
	<z2ta55d774e1005051437heb584584q6afca0b4b254d5d0@mail.gmail.com>
	<20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<20100506172201.GA28578@srcf.ucam.org>
	<20100506173807.GD30928@atomide.com>
	<20100506174331.GA29103@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100506174331.GA29103@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100506 10:39]:
> On Thu, May 06, 2010 at 10:38:08AM -0700, Tony Lindgren wrote:
> 
> > If your userspace keeps polling and has runaway timers, then you
> > could suspend it's parent process to idle the system?
> 
> If your userspace is suspended, how does it process the events that 
> generated a system wakeup? If we had a good answer to that then suspend 
> blockers would be much less necessary.

Well if your hardware runs off-while-idle or even just
retention-while-idle, then the basic shell works just fine waking up
every few seconds or so.

Then you could keep init/shell/suspend policy deamon running until
it's time to suspend the whole device. To cut down runaway timers,
you could already freeze the desktop/GUI/whatever earlier.

Regards,

Tony
