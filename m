From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] kprobes: check CONFIG_FREEZER instead of
	CONFIG_PM
Date: Sun, 11 Jan 2009 04:49:33 +0100
Message-ID: <20090111034933.GB28520__38682.1390050047$1231646029$gmane$org@elte.hu>
References: <200901062112.29227.rjw@sisk.pl> <200901062115.33286.rjw@sisk.pl>
	<20090107121659.GA16268@elte.hu>
	<alpine.LFD.2.00.0901091530090.16697@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901091530090.16697@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cheng Renquan <crquan@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> > > Check CONFIG_FREEZER instead of CONFIG_PM because kprobe booster
> > > depends on freeze_processes() and thaw_processes() when CONFIG_PREEMPT=y.
> > > 
> > > This fixes a linkage error which occurs when CONFIG_PREEMPT=y, CONFIG_PM=y
> > > and CONFIG_FREEZER=n.
> > > 
> > > Reported-by: Cheng Renquan <crquan@gmail.com>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  arch/ia64/kernel/kprobes.c |    2 +-
> > >  arch/x86/kernel/kprobes.c  |    2 +-
> > >  kernel/kprobes.c           |    2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > looks good, the x86 bits:
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> man, we have too many config options:-)

Agreed :-/

The idea is that of learning-via-pain: many config options cause many 
fixes, which causes people to reduce config options. At least that's the 
theory ;-) /me looks at his .config size and wonders

	Ingo
