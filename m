From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: 2.6.21-rc7-mm2 suspend bug. [kernel/kthread.c]
Date: Mon, 30 Apr 2007 16:58:04 +0200
Message-ID: <200704301658.05387.rjw__2108.6246859797$1177944888$gmane$org@sisk.pl>
References: <a8f16e2b0704291251l69c1b02ahb9b22370bc468fa1@mail.gmail.com>
	<20070430003946.b4d856b4.akpm@linux-foundation.org>
	<20070430100535.GA30975@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070430100535.GA30975@in.ibm.com>
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
To: ego@in.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, Dan Kruchinin <dubalom@gmail.com>, linux-kernel@vger.kernel.org, pm@smtp2.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 April 2007 12:05, Gautham R Shenoy wrote:
> On Mon, Apr 30, 2007 at 12:39:46AM -0700, Andrew Morton wrote:
> > On Sun, 29 Apr 2007 22:27:44 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Sunday, 29 April 2007 21:51, Dan Kruchinin wrote:
> > > > Hi all.
> > > > 
> > > > There is a problem on my macbook core duo with suspend.
> > > > after suspending when i'm trying to 'wake up' my notebook, it seems
> > > > that it works, but i don't see anything at my monitor. So i have to
> > > > reboot it to continue my work.
> > > 
> > > What exactly do you do to suspend?
> > > 
> > 
> > This is due to _cpu_down() calling kthread_bind() in state TASK_RUNNING.
> 
> The state should be TASK_INTERRUPTIBLE. That's the state of the thread
> 'p' should be in when we do a kthread_bind(p) in _cpu_down().
> 
> Are you sure about the TASK_RUNNING part ?

Well, the WARN_ON() in kernel/kthread.c, line166, is triggering here, so it
may be TASK_INTERRUPTIBLE too (should the WARN_ON() trigger in that case)?

Rafael
