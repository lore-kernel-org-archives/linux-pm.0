From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/6] cgroup: don't use
 subsys->can_attach_task() or ->attach_task()
Date: Wed, 24 Aug 2011 09:54:33 +0200
Message-ID: <20110824075433.GB14170__35410.1751152941$1314172534$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-5-git-send-email-tj@kernel.org>
	<20110824015739.GE28444@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110824015739.GE28444@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: lizf@cn.fujitsu.com, paul@paulmenage.org, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, containers@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Tue, Aug 23, 2011 at 06:57:39PM -0700, Matt Helsley wrote:
> On Wed, Aug 24, 2011 at 12:19:58AM +0200, Tejun Heo wrote:
> 
> <snip>
> 
> > * In cgroup_freezer, remove unnecessary NULL assignments to unused
> >   methods.  It's useless and very prone to get out of sync, which
> >   already happened.
> 
> You could post this part independently -- that might be best since
> I guess the taskset bits will need more discussion.

Urgh... I really think subsystems which aren't very isolated should
have its own tree.  Going through -mm works well if the changes are
isolated or all inter-dependent changes go through -mm too but it
stops working as soon as the changes start span across other git
trees.  If cgroup isn't expected to see a lot of changes in this cycle
(if so, please set up a git tree, it isn't difficult), the best
solution, I think, would be sticking w/ Rafael's branch.

Thanks.

-- 
tejun
