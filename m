From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 3 May 2010 18:11:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005031810000.1328-100000__44509.2615941123$1272924739$gmane$org@iolanthe.rowland.org>
References: <201005032338.26439.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005032338.26439.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 May 2010, Rafael J. Wysocki wrote:

> The main problem is that the entire suspend subsystem is going to work in a
> different way when suspend blockers are enforced.  Thus IMO it makes sense to
> provide a switch between the "opportunistic" and "forced" modes, because that
> clearly indicates to the user (or user space in general) how the whole suspend
> subsystem actually works at the moment.
> 
> As long as it's "opportunistic", the system will autosuspend if suspend
> blockers are not active and the behavior of "state" reflects that.  If you want
> to enforce a transition, switch to "forced" first.
> 
> That's not at all confusing if you know what you're doing.  The defailt mode is
> "forced", so the suspend subsystem works "as usual" by default.  You have to
> directly switch it to "opportunistic" to change the behavior and once you've
> done that, you shouldn't really be surprised that the behavior has changed.
> That's what you've requested after all.

How about changing the contents of /sys/power/state depending on the 
current policy?  When the policy is "forced" it should look the same as 
it does now.  When the policy is "opportunistic" it should contain 
"mem" and "on".

Alan Stern
