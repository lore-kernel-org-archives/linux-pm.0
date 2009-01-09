From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] kprobes: check CONFIG_FREEZER instead of
	CONFIG_PM
Date: Fri, 09 Jan 2009 15:30:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091530090.16697__36702.9475317851$1231533293$gmane$org@localhost.localdomain>
References: <200901062112.29227.rjw@sisk.pl> <200901062115.33286.rjw@sisk.pl>
	<20090107121659.GA16268@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20090107121659.GA16268@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cheng Renquan <crquan@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

> > Check CONFIG_FREEZER instead of CONFIG_PM because kprobe booster
> > depends on freeze_processes() and thaw_processes() when CONFIG_PREEMPT=y.
> > 
> > This fixes a linkage error which occurs when CONFIG_PREEMPT=y, CONFIG_PM=y
> > and CONFIG_FREEZER=n.
> > 
> > Reported-by: Cheng Renquan <crquan@gmail.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  arch/ia64/kernel/kprobes.c |    2 +-
> >  arch/x86/kernel/kprobes.c  |    2 +-
> >  kernel/kprobes.c           |    2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> looks good, the x86 bits:
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

man, we have too many config options:-)

applied.
thanks,
Len Brown, Intel Open Source Technology Center
