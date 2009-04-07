From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: commit 66c1ca breaks fbdev mode switching
Date: Tue, 7 Apr 2009 11:54:44 +0200
Message-ID: <20090407095443.GA9526__8683.8161143989$1239098305$gmane$org@linux>
References: <498817E2.3020008@gmail.com>
	<1233783983-28802-1-git-send-email-righi.andrea@gmail.com>
	<200903221748.42871.arvidjaar@gmail.com>
	<200903221857.20473.rjw@sisk.pl>
	<20090322145219.ad294615.akpm@linux-foundation.org>
	<20090406204718.ce4909b3.krzysztof.h1@poczta.fm>
	<20090406214528.GA17259@linux>
	<alpine.LRH.2.00.0904071105040.24773@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0904071105040.24773@vixen.sonytel.be>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 07, 2009 at 11:17:00AM +0200, Geert Uytterhoeven wrote:
> On Mon, 6 Apr 2009, Andrea Righi wrote:
> > On Mon, Apr 06, 2009 at 08:47:18PM +0200, Krzysztof Helt wrote:
> > > The commit 66c1ca breaks fbdev mode switching. The first mode
> > > (selected with mode_option or during boot) is ok but every mode
> > > switch with fbset locks up computer. If the commit is reverted
> > > mode switching works correctly.
> > > 
> > > I do not understand why. I would be grateful if someone else
> > > can confirm the problem as well.
> > > 
> > > The commit's details are:
> > > 
> > > commit 66c1ca019078220dc1bf968f2bb18421100ef147
> > > Author: Andrea Righi <righi.andrea@gmail.com>
> > > Date:   Tue Mar 31 15:25:18 2009 -0700
> > > 
> > >     fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency
> > 
> > Any lockdep info or oops? it just locks up the system?
> 
> # echo d > /proc/sysrq-trigger
> 
> [  187.654947] INFO: lockdep is turned off.
> 
> Strange, I do have lockdep enabled:
> 
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y

Probably because lockdep reported the first lock bug and disabled the
checking for the next lock bugs, to avoid log flooding of follow-up
bugs. Search the first lockdep occurrence in dmesg.

-Andrea
