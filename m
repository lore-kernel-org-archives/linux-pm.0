From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 22:58:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142256070.11498-100000__21372.7747126997$1273892374$gmane$org@netrider.rowland.org>
References: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil-Ky5L84JF7xn6su8VMtglBpZwCNIh7VgBiHgL@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 May 2010, Brian Swetland wrote:

> It provides useful functionality -- you apparently disagree, but the
> wakelock/suspendblock model is in use, shipping, and solving problems
> for quite a lot of android devices that have been shipping for a while
> now.  We actively go to lowest power state in idle (on omap, msm,
> etc), and use drivers that aggressively declock and depower modules
> (similar to runtime pm), but we have found that using the
> opportunistic suspend model combined with wakelocks allows us to
> attain even lower average power consumption in always-connected,
> actively-syncing devices.

Can you explain this in more detail?  Are you saying that some devices
go on generating interrupts and causing timers to be scheduled, even 
though what they're doing isn't important enough to prevent the system 
from powering down?

Alan Stern
