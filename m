From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] MMC: fix all hangs related to mmc/sd
	card insert/removal during suspend/resume.
Date: Tue, 22 Jun 2010 23:53:21 +0200
Message-ID: <201006222353.21349.rjw__17841.8198171586$1277243734$gmane$org@sisk.pl>
References: <1276809695.28201.13.camel@maxim-laptop>
	<201006221119.06210.rjw@sisk.pl>
	<1277241450.10907.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277241450.10907.4.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Philip Langdale <philipl@overt.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 22, 2010, Maxim Levitsky wrote:
> On Tue, 2010-06-22 at 11:19 +0200, Rafael J. Wysocki wrote: 
> > On Tuesday, June 22, 2010, Maxim Levitsky wrote:
> > > On Mon, 2010-06-21 at 22:26 +0200, Rafael J. Wysocki wrote: 
...
> > > I *do* use freezable  work-queue.
> > 
> > I overlooked that, sorry.
> > 
> > > However since this is pm notifier, it is called before userspace and the
> > > workqueue is frozen.
> > > Therefore I would like manually to freeze the workqueue from the pm
> > > notifier.
> > 
> > No, that won't work.  You need to find an alternative solution.  I guess you
> > may insert a work item that's going to sleep until a condition is
> > satisfied (analogous to a workqueue barrier) and wait for it to 
> This screams to be done in generic way.
> Something like suspend_workqueue() and resume_workqueue();

Well, there was no need for that until now. :-)

> In addition to that I just found that .suspend function sometimes can
> return -ENOSYS, which triggers card removal. I wrongly remove that chunk
> of code.
> 
> To make the thing picture perfect I would have to invest more time to
> it, I will do so as soon as I finish my exams.
> 
> Meanwhile the current patch already fixes all but corner cases or rather
> nasty hang on suspend with any MMC/SD card inserted.

OK

I think Andrew has already taken [2/2].

Andrew, who's maintaining MMC now?

Rafael
