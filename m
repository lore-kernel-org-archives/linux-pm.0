From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Tue, 4 May 2010 09:59:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005040953510.1729-100000__30738.5641419843$1272981651$gmane$org@iolanthe.rowland.org>
References: <20100504051256.GC3043@thegnar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504051256.GC3043@thegnar.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 May 2010, mark gross wrote:

> You know things would be so much easier if the policy was a one-shot
> styled thing.  i.e. when enabled it does what it does, but upon resume
> the policy must be re-enabled by user mode to get the opportunistic
> behavior.  That way we don't need to grab the suspend blocker from the
> wake up irq handler all the way up to user mode as the example below
> calls out.  I suppose doing this would put a burden on the user mode code
> to keep track of if it has no pending blockers registered after a wake
> up from the suspend.  but that seems nicer to me than sprinkling
> overlapping blocker critical sections from the mettle up to user mode.
> 
> Please consider making the policy a one shot API that needs to be
> re-enabled after resume by user mode.  That would remove my issue with
> the design.

This won't work right if a second IRQ arrives while the first is being
processed.  Suppose the kernel driver for the second IRQ doesn't
activate a suspend blocker, and suppose all the userspace handlers for
the first IRQ end (and the opportunistic policy is re-enabled) before
the userspace handler for the second IRQ can start.  Then the system
will go back to sleep before userspace can handle the second IRQ.

Alan Stern
