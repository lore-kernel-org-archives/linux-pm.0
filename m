From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Thu, 25 Aug 2011 11:20:45 +0200
Message-ID: <20110825092045.GG3286__4401.76400957188$1314264203$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-4-git-send-email-tj@kernel.org>
	<CALdu-PDAgqeRJt5vqTB9wddwz70Yn+Jf-Pb0dDKDBD_q37tHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALdu-PDAgqeRJt5vqTB9wddwz70Yn+Jf-Pb0dDKDBD_q37tHQg@mail.gmail.com>
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
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Aug 25, 2011 at 02:14:12AM -0700, Paul Menage wrote:
> The general idea of passing consistent information to all *attach
> methods seems good, but isn't it simpler to just fix up the various
> method signatures?

I think having separate ->attach() and ->attach_task() is inherently
broken.  Look at the memcg discussion I had in this thread for
reference and as soon as we need to do something across the tasks
being migrated, iteration-by-callback becomes very painful.
e.g. let's say memcg wants to find the mm->owner and wants to print
warning or fail if that doesn't work out.  How would that be
implemented if it's iterating by callback.

> The whole point of having *attach() and *attach_task() was to minimize
> the amount of boilerplate (in this case, iterating across a new
> cgroup_taskset abstraction) in the subsystems, leaving that to the
> cgroups framework.

Yeah, I agree with making things easier for subsystems but I violently
disagree that iteration-by-callback is helpful in any way.  If
control-loop style iterator is at all possible, it's almost always
better to go that way.

Thanks.

-- 
tejun
