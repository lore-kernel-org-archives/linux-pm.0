From: "Paul Menage" <menage@google.com>
Subject: Re: [RFC PATCH 5/5] Add a Signal Control Group Subsystem
Date: Wed, 23 Apr 2008 08:37:45 -0700
Message-ID: <6599ad830804230837x48860632m7c41e425458ba6b3__24593.9718014144$1208966926$gmane$org@mail.gmail.com>
References: <20080423142517.062433911@us.ibm.com>
	<20080423142518.703428301@us.ibm.com> <480F5321.9030008@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <480F5321.9030008@fr.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 23, 2008 at 8:17 AM, Cedric Le Goater <clg@fr.ibm.com> wrote:
> Hello Matt !
>
>  > Add a signal control group subsystem that allows us to send signals to all tasks
>  > in the control group by writing the desired signal(7) number to the kill file.
>  >
>  > NOTE: We don't really need per-cgroup state, but control groups doesn't support
>  > stateless subsystems yet.
>  >
>  > Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
>  > ---
>  >  include/linux/cgroup_signal.h |   28 +++++++++
>  >  include/linux/cgroup_subsys.h |    6 +
>  >  init/Kconfig                  |    6 +
>  >  kernel/Makefile               |    1
>  >  kernel/cgroup_signal.c        |  129 ++++++++++++++++++++++++++++++++++++++++++
>  >  5 files changed, 170 insertions(+)
>
>
>  I think there is a small race with new tasks entering the cgroup
>  while it's beeing killed, and a _fork ops would handle that. nop ?
>

I never saw the actual patch (what lists did it go out to?) but I
suspect that this is one of those operations that's just going to be
inherently racy, and that the API should guarantee to affect all tasks
that are members of the group for the entirety of the operation, but
with no guarantees about what happens to tasks that enter or leave in
the meantime.

Paul
