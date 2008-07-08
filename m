From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Tue, 8 Jul 2008 12:31:50 +0900
Message-ID: <20080708123150.3034d83f.kamezawa.hiroyu__8159.02890540219$1215530077$gmane$org@jp.fujitsu.com>
References: <20080707225823.502032693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080707225823.502032693@us.ibm.com>
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
Cc: Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

Hi, could I make brief questions ?

On Mon, 07 Jul 2008 15:58:23 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:
> to get status of the freezer subsystem :
> 
>    # cat /containers/0/freezer.state
>    RUNNING
> 
> to freeze all tasks in the container :
> 
>    # echo FROZEN > /containers/0/freezer.state
>    # cat /containers/0/freezer.state
>    FREEZING
>    # cat /containers/0/freezer.state
>    FROZEN
> 
I'm just curious.

1. When we see FREEZING and have to retry ?
   While there are some threads which wait for some event ?

2. What happens when FROZEN threads are moved to other group ?
   Can we move them ?
   Can we wake them up (if it can be moved) ?
   What operations are allowed to frozen threads ?

Thanks,
-Kame
