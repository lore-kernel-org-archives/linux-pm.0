From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 19:05:41 -0700
Message-ID: <20100507020541.GH30928__32866.7041067549$1273198012$gmane$org@atomide.com>
References: <20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<20100506172201.GA28578@srcf.ucam.org>
	<20100506173807.GD30928@atomide.com>
	<20100506174331.GA29103@srcf.ucam.org>
	<20100506183335.GE30928@atomide.com>
	<20100506184418.GA30669@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100506184418.GA30669@srcf.ucam.org>
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

* Matthew Garrett <mjg@redhat.com> [100506 11:39]:
> On Thu, May 06, 2010 at 11:33:35AM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100506 10:39]:
> > > On Thu, May 06, 2010 at 10:38:08AM -0700, Tony Lindgren wrote:
> > > 
> > > > If your userspace keeps polling and has runaway timers, then you
> > > > could suspend it's parent process to idle the system?
> > > 
> > > If your userspace is suspended, how does it process the events that 
> > > generated a system wakeup? If we had a good answer to that then suspend 
> > > blockers would be much less necessary.
> > 
> > Well if your hardware runs off-while-idle or even just
> > retention-while-idle, then the basic shell works just fine waking up
> > every few seconds or so.
> 
> And the untrusted userspace code that's waiting for a network packet? 
> Adding a few seconds of latency isn't an option here.

Hmm well hitting retention and wake you can basically do between
jiffies. Hitting off mode in idle has way longer latencies,
but still in few hundred milliseconds or so, not seconds.

And cpuidle pretty much takes care of hitting the desired C state
for you. This setup is totally working on Nokia N900 for example,
it's hitting off modes in idle and running all the time, it never
suspends.

Regards,

Tony
