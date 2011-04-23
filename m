From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] Two power management fixes for 2.6.39
Date: Sat, 23 Apr 2011 19:55:43 +0200
Message-ID: <201104231955.44001.rjw__42956.9051288583$1303581403$gmane$org@sisk.pl>
References: <201104212211.03185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104212211.03185.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 21, 2011, Rafael J. Wysocki wrote:
> Hi Linus,
> 
> Please pull two power management fixes for 2.6.39 from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes
> 
> They fix bugs related to syscore_ops introduced earlier in this cycle.

Well, I guess I should have said they fixed regressions related to the introduction
of syscore_ops.  At least the second commit fixes real breakage (the error code
paths should not be broken as well, but they aren't executed too often).

Anyway, next week I'm going to have more regression fixes ready, so I'll send
a new pull request at that time.

>  arch/x86/kernel/apm_32.c |    5 +++++
>  drivers/base/syscore.c   |    2 ++
>  drivers/xen/manage.c     |    9 ++++++++-
>  kernel/kexec.c           |    7 +++++++
>  kernel/power/hibernate.c |   10 ++++++++--
>  kernel/power/suspend.c   |    5 ++++-
>  6 files changed, 34 insertions(+), 4 deletions(-)
> 
> ---------------
> 
> Rafael J. Wysocki (2):
>       PM: Fix error code paths executed after failing syscore_suspend()
>       PM: Add missing syscore_suspend() and syscore_resume() calls

Thanks,
Rafael
