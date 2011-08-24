From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 4/6] cgroup: don't use
 subsys->can_attach_task() or ->attach_task()
Date: Tue, 23 Aug 2011 18:57:39 -0700
Message-ID: <20110824015739.GE28444__47586.6318135106$1314151151$gmane$org@count0.beaverton.ibm.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-5-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314138000-2049-5-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: lizf@cn.fujitsu.com, paul@paulmenage.org, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, containers@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2011 at 12:19:58AM +0200, Tejun Heo wrote:

<snip>

> * In cgroup_freezer, remove unnecessary NULL assignments to unused
>   methods.  It's useless and very prone to get out of sync, which
>   already happened.

You could post this part independently -- that might be best since
I guess the taskset bits will need more discussion.

Cheers,
	-Matt Helsley
