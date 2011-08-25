From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Thu, 25 Aug 2011 10:40:06 +0200
Message-ID: <CAOS58YPM=cuWjAF+VJ4QJ8bnRcVtaDCVXBJCpdWg+2=2GmnKrA__18805.604070849$1314261799$gmane$org@mail.gmail.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-4-git-send-email-tj@kernel.org>
	<20110825093958.75b95bd8.kamezawa.hiroyu@jp.fujitsu.com>
	<20110825082049.GC3286@htj.dyndns.org>
	<20110825172140.eb34809f.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110825172140.eb34809f.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Aug 25, 2011 at 10:21 AM, KAMEZAWA Hiroyuki
<kamezawa.hiroyu@jp.fujitsu.com> wrote:
>> Hmmm... the above is basically identity transformation of the existing
>> code. =A0If the above is broken, the current code is broken too. =A0Is i=
t?
>>
> Current code is not broken.

Trust me.  If the posted code is broken, the current code is too. It
is an IDENTITY transformation.

> mem_cgroup_can_attach(....., task) need to do real job only when task->mm=
->owner
> =3D=3D task. In this modification, you pass a set of task at once.

Before the change, cgroup would migrate multiple tasks all the same
but memcg wouldn't have noticed it unless it opted in explicitly using
[can_]attach_task(). When multiple tasks were moving, [can_]attach()
would only be called with the leader whether the leader actually is
changing cgroup or not. The interface sucked and it wasn't properly
documented but that's what was happening. The interface change is just
making the breakage obvious - +1 for the new interface. :)

> So, mem_cgroup_can_attach() need to check _all_ tasks in tset rather than=
 a
> first task in tset. please scan and find mm->owner.
>
> Anyway, if you merge this onto mm-tree first, I think I can have time to
> write a fix up if complicated.

As for specific merging order, it shouldn't matter all that much but
if you wanna backport fixes for -stable, maybe it would make more
sense to sequence the fix before this change.

Thank you.

-- =

tejun
