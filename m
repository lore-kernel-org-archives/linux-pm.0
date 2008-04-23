From: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [RFC PATCH 5/5] Add a Signal Control Group Subsystem
Date: Wed, 23 Apr 2008 17:17:53 +0200
Message-ID: <480F5321.9030008__3391.13211161948$1208964237$gmane$org@fr.ibm.com>
References: <20080423142517.062433911@us.ibm.com>
	<20080423142518.703428301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080423142518.703428301@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello Matt !

> Add a signal control group subsystem that allows us to send signals to all tasks
> in the control group by writing the desired signal(7) number to the kill file.
> 
> NOTE: We don't really need per-cgroup state, but control groups doesn't support
> stateless subsystems yet.
> 
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> ---
>  include/linux/cgroup_signal.h |   28 +++++++++
>  include/linux/cgroup_subsys.h |    6 +
>  init/Kconfig                  |    6 +
>  kernel/Makefile               |    1 
>  kernel/cgroup_signal.c        |  129 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 170 insertions(+)


I think there is a small race with new tasks entering the cgroup
while it's beeing killed, and a _fork ops would handle that. nop ? 

Thanks,

C. 
