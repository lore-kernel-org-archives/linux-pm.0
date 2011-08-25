From: Paul Menage <paul@paulmenage.org>
Subject: Re: [PATCH 2/6] cgroup: improve old cgroup handling in
	cgroup_attach_proc()
Date: Thu, 25 Aug 2011 01:51:39 -0700
Message-ID: <CALdu-PAj1ZUmB2ixxA6yeppB8MerBGk1cSeQadobH0H4cRSe7Q__9995.58440312303$1314288026$gmane$org@mail.gmail.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314138000-2049-3-git-send-email-tj@kernel.org>
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
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 23, 2011 at 3:19 PM, Tejun Heo <tj@kernel.org> wrote:
> cgroup_attach_proc() behaves differently from cgroup_attach_task() in
> the following aspects.
>
> * All hooks are invoked even if no task is actually being moved.
>
> * ->can_attach_task() is called for all tasks in the group whether the
> =A0new cgrp is different from the current cgrp or not; however,
> =A0->attach_task() is skipped if new equals new. =A0This makes the calls
> =A0asymmetric.
>
> This patch improves old cgroup handling in cgroup_attach_proc() by
> looking up the current cgroup at the head, recording it in the flex
> array along with the task itself, and using it to remove the above two
> differences. =A0This will also ease further changes.

While I'm all in favour of making things more consistent, do we need
such a big change?

In particular, making the group flex-array entries contain both a task
and a cgroup appears to be only necessary in order to skip tasks where
new_cgroup =3D=3D old_cgroup. Can't we get the same effect by simply
leaving all such tasks out of the flex-array in the first place?

Paul
