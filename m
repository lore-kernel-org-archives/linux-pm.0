From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] cgroup: introduce cgroup_taskset and
 consolidate subsys methods, take#2
Date: Fri, 26 Aug 2011 00:48:59 +0200
Message-ID: <20110825224859.GU2803__10830.4750327536$1314313941$gmane$org@mtj.dyndns.org>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314312192-26885-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, paul@paulmenage.org, lizf@cn.fujitsu.com
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2011 at 12:43:06AM +0200, Tejun Heo wrote:
> and is based on the current linux-pm/pm-freezer (7b5b95b3f5 "freezer:
> remove should_send_signal() and update frozen()"), and available in
> the following git tree.
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git freezer

Oops, that should have been

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git cgroup_taskset

The above hasn't been properly mirrored yet (it should soon).  The
commit ID should be 53fd922e120c4ba0b65e388c2cda3c858f92db7c.
master.korg contains the master copy.

 ssh://master.kernel.org/pub/scm/linux/kernel/git/tj/misc.git cgroup_taskset

Thanks.

-- 
tejun
