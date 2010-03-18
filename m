From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Thu, 18 Mar 2010 10:13:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003181010220.1665-100000@iolanthe.rowland.org>
References: <874okepojl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <874okepojl.fsf@deeprootsystems.com>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Mar 2010, Kevin Hilman wrote:

> >> > @@ -729,6 +729,26 @@ static void platform_pm_complete(struct device *dev)
> >> >  
> >> >  #ifdef CONFIG_SUSPEND
> >> 
> >> This probably should be CONFIG_SLEEP.
> >
> > CONFIG_PM_SLEEP to be precise.
> 
> That #ifdef was not part of my patch, it was just part of the diff
> context.  I'm just adding these new hooks inside the same ifdef that
> the platform_bus system PM hooks are defined.
> 
> Are you suggesting I also fixup the #ifdef in that code?

That would be a good idea.  It can be done in a separate patch.

The point is that CONFIG_SUSPEND is defined only when you enable
standby or suspend-to-RAM, and CONFIG_HIBERNATION is defined only when
you enable suspend-to-disk, whereas CONFIG_SLEEP is defined when either
of the others is.

Alan Stern
