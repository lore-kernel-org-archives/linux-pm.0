From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/6] cgroup: improve old cgroup handling in
 cgroup_attach_proc()
Date: Thu, 25 Aug 2011 11:03:23 +0200
Message-ID: <20110825090323.GD3286__37273.9395629198$1314263096$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-3-git-send-email-tj@kernel.org>
	<CALdu-PAj1ZUmB2ixxA6yeppB8MerBGk1cSeQadobH0H4cRSe7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALdu-PAj1ZUmB2ixxA6yeppB8MerBGk1cSeQadobH0H4cRSe7Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Menage <paul@paulmenage.org>
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Aug 25, 2011 at 01:51:39AM -0700, Paul Menage wrote:
> In particular, making the group flex-array entries contain both a task
> and a cgroup appears to be only necessary in order to skip tasks where
> new_cgroup == old_cgroup. Can't we get the same effect by simply
> leaving all such tasks out of the flex-array in the first place?

In general, the interface *should* give full information to subsys
methods at each stage including the old cgroup each task is migrating
from and the new cgroup; otherwise, they soon end up developing weird
acrobatics to work around shortcomings in the interface or being
outright buggy, so let's please look past the fixes which are
necessary immediately and think about what a proper interface should
look like.

I mean, seriously, why did ->attach_task() take @new_cgroup when it's
called after migration happened while ->attach() had access to the old
cgroup of the last iterated task in the group?  What the hell does
that even mean?

And, why is this a big change?  The big part is change of interface
but that we need to do anyway.  This one is just adding an entry to
the flex array.

Thanks.

-- 
tejun
