From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
 resumes after STR
Date: Sat, 19 May 2007 00:04:13 -0700
Message-ID: <20070519000413.75badb6f.akpm__47884.0386997492$1179558472$gmane$org@linux-foundation.org>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070518002240.bc08e811.akpm@linux-foundation.org>
	<20070519064829.GA15518@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070519064829.GA15518@inferi.kami.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, ACPI@smtp2.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 19 May 2007 15:48:29 +0900 Mattia Dongili <malattia@linux.it> wrote:

> On Fri, May 18, 2007 at 12:22:40AM -0700, Andrew Morton wrote:
> > On Fri, 18 May 2007 16:15:24 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > 
> > > Hello,
> > > 
> > > After finally catching fw-{ohci,core} to be problematic during resume,
> > > I'm now experiencing an immediate resume after suspending.
> > > 
> > > 2.6.21-rc7-mm* didn't even suspend, my last known suspend-and-resuming
> > > kernel was 2.6.21-rc5-mm3 (I know one other vaio SZ user could STR with
> > > 2.6.21-rc6-mm* after the cpuidle fixes).
> > > 
> > > my .config is: http://oioio.altervista.org/linux/config-2.6.22-rc1-mm1-1
> > > and a str cycle with PM_DEBUG=y:
> > > http://oioio.altervista.org/linux/dmesg-SRT-immediately-resumes.txt
> ...
> > > Any idea where to start from? (bisecting is ok, but it'll take some
> > > time...)
> > 
> > Bisecting isn't that bad ;) I'd pick git-acpi.patch as the starting point.
> 
> ok, git-acpi.patch is not the bad boy :)
> Anyway what we have is a regression in 2.6.22-rc1 since the laptop can't
> suspend (it sits on the "Stopping tasks" console screen) while 2.6.21
> can.
> I'm now bisecting this, will come to -mm1 later when done with this one.

OK, thanks.

> Who is the regression-guy?

Len, usually ;)    But I think you meant Michal, cc'ed here.
