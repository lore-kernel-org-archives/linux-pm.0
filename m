From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Runtime PM: Adding explicit check to make
 sure dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 13:14:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912041301160.3070-100000@iolanthe.rowland.org>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4F135@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298C5C4F135@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Dec 2009, Mahalingam, Nithish wrote:

> Also wanted to ask - do you think acquiring spinlock every time before 
> even checking if parent supports runtime PM, optimal?

You need to change your thinking.  You're making a very basic mistake, 
and you have made the same mistake in every email message on this 
subject.

You keep talking about "parent supports runtime PM".  But that's not 
what the code actually checks.

For one thing, this isn't really about the parent device's capabilities
-- runtime support is at least as much a property of the driver as of
the device.  But more importantly, the field you're checking doesn't
mean what you think it means.  If parent->power.disable_depth > 0, it
doesn't mean that the parent doesn't support runtime PM.  It means that
the parent is _currently disabled_ for runtime PM -- and the parent may
become enabled at some time in the future.

That's why disable_depth is manipulated under spinlock protection.  One 
thread might be looking at it while another thread is changing it.  Not 
using the spinlock would leave you open to races.

The question of efficiency or optimality depends on how often we have a 
device using runtime PM whose parent is disabled.  I don't know how 
often that will occur.  As more and more drivers start implementing 
runtime PM, it will occur less and less frequently.

The most troublesome case arises when you have a parent which is 
disabled for runtime PM and later on becomes enabled.  This may not 
happen very often -- it may not happen at all.  I would expect that if 
a device changes from disabled to enabled, it probably does so before 
acquiring any children.  But we can't be certain of this.

Alan Stern
