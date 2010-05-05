From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 11:44:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005051136140.1885-100000__39253.977899398$1273074327$gmane$org@iolanthe.rowland.org>
References: <20100505015050.GA30591@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505015050.GA30591@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <mgross@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, markgross@thegnar.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 May 2010, mark gross wrote:

> Thanks, I think I'm starting to get it.  From this it seems that the
> system integrator needs to identify those wake up sources that need to
> be able to block a suspend, and figure out a way of acknowledging from
> user mode, that its now ok to allow a suspend to happen.

The second part is easy.  Userspace doesn't need to do anything special 
to acknowledge that a suspend is now okay; it just has to remove the 
conditions that led the driver to block suspends in the first place.

For example, if suspends are blocked because some input event has been
queued, emptying the input event queue should unblock suspends.

> The rev-6 proposed way is for the integrator to implement overlapping
> blocker sections from ISR up to user mode for selected wake up devices
> (i.e. the modem)
> 
> There *has* to be a better way.

Why?  What's wrong with overlapping blockers?  It's a very common
idiom.  For example, the same sort of thing is used when locking
subtrees of a tree: You lock the root node, and then use overlapping
locks on the nodes leading down to the subtree you're interested in.

> Can't we have some notification based thing that supports user mode
> acks through a misc device or sysfs thing?   Anything to avoid the
> overlapping blocker sections. 

Userspace acks aren't the issue; the issue is how (and when) kernel 
drivers should initiate a blocker.  Switching to notifications, misc 
devices, or sysfs won't help solve this issue.

> True, you need an ack back from user mode for when its ok to allow
> suspend to happen.  This ack is device specific and needs to be custom
> built per product to its wake up sources.

No and no.  Nothing special is needed.  All userspace needs to do is 
remove the condition that led to the blocker being enabled initially -- 
which is exactly what userspace would do normally anyway.

Alan Stern
