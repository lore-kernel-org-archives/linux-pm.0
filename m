From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Wed, 17 Mar 2010 10:47:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003171040260.1734-100000@iolanthe.rowland.org>
References: <87bpeovtqg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87bpeovtqg.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Mar 2010, Kevin Hilman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Wed, 3 Feb 2010, Kevin Hilman wrote:
> >
> >> Hello,
> >> 
> >> I'm implementing runtime PM for the TI OMAP SoCs by overriding the
> >> platform_bus hooks.  All is working well for runtime PM, but it's 
> >> brought up a couple snags for static PM.
> >> 
> >> Most of our drivers don't really need to distinguish between runtime
> >> PM and static PM as we can hit the same power states when idle as we
> >> can in suspend.  Before switching to runtime PM we've been using the
> >> clock framework to do both runtime PM and static PM.  The driver would
> >> disable its clocks & HW when idle and when going into suspend,
> >> typically using a common 'disable' function.
> >> 
> >> In converting a test driver to runtime PM, I just converted this
> >> common disable function from a clock disable to a
> >> pm_runtime_put_sync() and the common enable function to do a
> >> pm_runtime_get_sync().  This all worked well for runtime PM, resulting
> >> in my platform_pm_runtime_* hooks being called where I can then
> >> disable/re-enable the clocks/HW etc.  So far so good.
> >> 
> >> However, I'm not able to use the common function in the static suspend
> >> path because dpm_prepare() does a pm_runtime_get_no_resume() which
> >> prevents any runtime PM transitions during suspend.
> >> 
> >> I understand the motivation for this is probably to prevent runtime PM
> >> transitions during static suspend, and that makes sense.  However, I'm
> >> wondering if there's some other way to handle my problem without
> >> having to have the driver have different paths for static and runtime
> >> PM.
> >
> > The system PM methods could directly call the runtime_suspend and
> > runtime_resume methods (which presumably is where you actually disable
> > or enable the clocks etc.), instead of going indirectly through
> > pm_runtime_put_sync() and pm_runtime_get_sync().
> >
> 
> [Revisiting this thread again... with a slightly different problem]
> 
> In my case, the driver's runtime_suspend and runtime_resume hooks are
> not where the clocks are managed.  The actual hardware enable/disable
> is done in the bus-level runtime PM hooks, in this case platform_bus.
> So having the system PM methods directly call the drivers runtime PM
> methods doesn't help.  In fact, because we handle the hardware at the
> bus level, most drivers can live without any runtime PM methods, and
> simply use get/put.
> 
> I've worked around this temporarily by calling the
> bus->pm->runtime_suspend() and ->runtime_resume() methods from the
> system PM methods, but am curious if that is an acceptable solution.

If the platform bus manages the clocks from within its runtime-PM 
routines, then it ought to provide a similar service from within its 
system-PM routines.  You could do it by calling the bus's runtime-PM 
routines indirectly through the method pointers (as you do now), or by 
calling the runtime-PM routines directly, or by making the runtime-PM 
routines and the system-PM routines both call a separate common 
function responsible for managing the clocks.

Each of these approaches is acceptable, assuming it doesn't mess up any 
of the other platform drivers in your system.

Alan Stern
