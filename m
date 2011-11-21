From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 05/10] cgroup: subsys->attach_task() should
 be called after migration
Date: Mon, 21 Nov 2011 14:04:04 -0800
Message-ID: <20111121220404.GN25776@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-6-git-send-email-tj@kernel.org>
	<20111114200553.GG9446@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111114200553.GG9446@somewhere>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: akpm@linux-foundation.org, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2011 at 09:06:08PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 01, 2011 at 04:46:28PM -0700, Tejun Heo wrote:
> > cgroup_attach_task() calls subsys->attach_task() after
> > cgroup_task_migrate(); however, cgroup_attach_proc() calls it before
> > migration.  This actually affects some of the users.  Update
> > cgroup_attach_proc() such that ->attach_task() is called after
> > migration.
> 
> That's already upstream.

Yeap, just dropped this one while rebasing.

Thanks.

-- 
tejun
