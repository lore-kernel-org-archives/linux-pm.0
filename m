From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/6] cgroup: subsys->attach_task() should be
 called after migration
Date: Wed, 24 Aug 2011 02:32:36 +0200
Message-ID: <20110824003234.GB23979__36105.6716916666$1314146037$gmane$org@somewhere>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314138000-2049-2-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2011 at 12:19:55AM +0200, Tejun Heo wrote:
> cgroup_attach_task() calls subsys->attach_task() after
> cgroup_task_migrate(); however, cgroup_attach_proc() calls it before
> migration.  This actually affects some of the users.  Update
> cgroup_attach_proc() such that ->attach_task() is called after
> migration.

There have been a patch posted recently:

        "[PATCH][BUGFIX] cgroups: fix ordering of calls in cgroup_attach_proc"

that not only fixes that ordering but also only attach the task if the
migration happened correctly (task not exited).

Can somebody queue it for 3.2 ?
