From: Mattia Dongili <malattia@linux.it>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Sun, 20 May 2007 15:14:08 +0900
Message-ID: <20070520061408.GA3325__1051.21251331202$1179641920$gmane$org@inferi.kami.home>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070518002240.bc08e811.akpm@linux-foundation.org>
	<20070519064829.GA15518@inferi.kami.home>
	<20070519000413.75badb6f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070519000413.75badb6f.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 19, 2007 at 12:04:13AM -0700, Andrew Morton wrote:
> On Sat, 19 May 2007 15:48:29 +0900 Mattia Dongili <malattia@linux.it> wrote:
> 
> > On Fri, May 18, 2007 at 12:22:40AM -0700, Andrew Morton wrote:
> > > On Fri, 18 May 2007 16:15:24 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > After finally catching fw-{ohci,core} to be problematic during resume,
> > > > I'm now experiencing an immediate resume after suspending.
> > > > 
> > > > 2.6.21-rc7-mm* didn't even suspend, my last known suspend-and-resuming
> > > > kernel was 2.6.21-rc5-mm3 (I know one other vaio SZ user could STR with
> > > > 2.6.21-rc6-mm* after the cpuidle fixes).
> > > > 
> > > > my .config is: http://oioio.altervista.org/linux/config-2.6.22-rc1-mm1-1
> > > > and a str cycle with PM_DEBUG=y:
> > > > http://oioio.altervista.org/linux/dmesg-SRT-immediately-resumes.txt
> > ...
> > > > Any idea where to start from? (bisecting is ok, but it'll take some
> > > > time...)
> > > 
> > > Bisecting isn't that bad ;) I'd pick git-acpi.patch as the starting point.
> > 
> > ok, git-acpi.patch is not the bad boy :)

but very very close:
acpi-driver-model-flags-and-platform_enable_wake.patch

cheers
-- 
mattia
:wq!
