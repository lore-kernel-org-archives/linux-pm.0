From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 1/6] cgroup: subsys->attach_task() should be
 called after migration
Date: Wed, 24 Aug 2011 09:31:19 +0800
Message-ID: <4E545467.9070202__21603.789603296$1314149524$gmane$org@cn.fujitsu.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-2-git-send-email-tj@kernel.org>
	<20110824003234.GB23979@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110824003234.GB23979@somewhere>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: paul@paulmenage.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, containers@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> There have been a patch posted recently:
> 
>         "[PATCH][BUGFIX] cgroups: fix ordering of calls in cgroup_attach_proc"
> 
> that not only fixes that ordering but also only attach the task if the
> migration happened correctly (task not exited).
> 
> Can somebody queue it for 3.2 ?
> 

cgroup patches normally go through -mm tree.
