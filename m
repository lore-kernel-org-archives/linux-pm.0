From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/6] cgroup: kill subsys->can_attach_task(),
 pre_attach() and attach_task()
Date: Thu, 1 Sep 2011 20:22:21 +0900
Message-ID: <20110901112221.GA2752__2676.7247509726$1314929367$gmane$org@htj.dyndns.org>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-7-git-send-email-tj@kernel.org>
	<20110830201030.GC15953@somewhere.redhat.com>
	<20110831070313.GA29179@mtj.dyndns.org>
	<20110831134220.GB20598@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831134220.GB20598@somewhere>
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
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Aug 31, 2011 at 03:42:24PM +0200, Frederic Weisbecker wrote:
> My task counter subsystem patchset brings a cancel_attach_task() callback
> that cancels can_attach_task() effects.
> 
> I thought that rebased on top of your patch it's going to be merged inside
> cancel_attach() but OTOH we can't cancel the effect of failed migration
> on a thread that way.
> 
> May be we need to keep a cancel_attach_task() just for that purpose?

We can do that but I think that becomes a bit too complex and fragile.
That path won't be traveled unless it races against exit.  Bugs will
be difficult to detect and reproduce.  In this respect, the current
code already seems racy.  ->can_attach (or other methods in the attach
path) and ->exit can race each other and I don't think all subsystems
handle that properly.

IMHO the right thing to do here is simplifying synchronization rules
so that nothing else happens while migration is in progress.

Thanks.

-- 
tejun
