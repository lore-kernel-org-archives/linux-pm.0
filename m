From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Tue, 08 Jul 2008 12:39:14 -0700
Message-ID: <1215545954.9023.120.camel__17782.3215992705$1215547202$gmane$org@localhost.localdomain>
References: <20080707225823.502032693@us.ibm.com>
	<20080708123150.3034d83f.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080708123150.3034d83f.kamezawa.hiroyu@jp.fujitsu.com>
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
Cc: Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Cedric was accidentally not Cc'd on the introduction (PATCH 0). Adding
him.

On Tue, 2008-07-08 at 12:31 +0900, KAMEZAWA Hiroyuki wrote:
> Hi, could I make brief questions ?
> 
> On Mon, 07 Jul 2008 15:58:23 -0700
> Matt Helsley <matthltc@us.ibm.com> wrote:
> > to get status of the freezer subsystem :
> > 
> >    # cat /containers/0/freezer.state
> >    RUNNING
> > 
> > to freeze all tasks in the container :
> > 
> >    # echo FROZEN > /containers/0/freezer.state
> >    # cat /containers/0/freezer.state
> >    FREEZING
> >    # cat /containers/0/freezer.state
> >    FROZEN
> > 
> I'm just curious.
> 
> 1. When we see FREEZING and have to retry ?

One example is when some processes are in the a specific portion of
vfork() you might see FREEZING and have to retry.

>    While there are some threads which wait for some event ?

Depending on which kind of "wait" they are performing, yes. If it's
uninterruptible sleep and the PF_FROZEN flag is not set then you might
see FREEZING.

> 2. What happens when FROZEN threads are moved to other group ?
>    Can we move them ?

If the destination cgroup is not FROZEN, yes.

If the destination cgroup is FREEZING this works as expected.

If the destination cgroup is RUNNING you'd have a problem unfreezing the
task. This happends because the cgroup has a state inconsistent with the
task's state. To unfreeze the task you'd have to try to freeze and then
unfreeze the destination cgroup. 

There are several ways I could change this.

One is to try and disallow users from moving frozen tasks. That doesn't
seem like a good approach since it would require a new cgroups interface
"can_detach()". 

However we can prevent attach so I could add checks that look at the
attaching tasks's state and refuse the attach when the task's state
(unfrozen, frozen) is inconsistent with the cgroup state (RUNNING,
FREEZING, FROZEN). I'll send a fifth patch on top of this series showing
this idea.

Rather than refuse to allow attach we could change the destination
cgroup's state during attach so that the two states are consistent.
However, this introduces more ugly cases for userspace to be aware of.

>    Can we wake them up (if it can be moved) ?

You can't wake them until you've unfrozen them.

>    What operations are allowed to frozen threads ?

Any operation that doesn't require the threads to run.

Cheers,
	-Matt Helsley
