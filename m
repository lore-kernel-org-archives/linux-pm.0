From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Mon, 11 May 2009 17:11:11 -0700
Message-ID: <20090511171111.9d74e4c0.akpm__21906.7538543188$1242087513$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905120044.37342.rjw@sisk.pl>
	<20090511160704.e1fa2512.akpm@linux-foundation.org>
	<200905120128.16780.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905120128.16780.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, mel@csn.ul.ie, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 12 May 2009 01:28:15 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 12 May 2009, Andrew Morton wrote:
> > On Tue, 12 May 2009 00:44:36 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Which means this patch:
> > > http://marc.info/?l=linux-kernel&m=124165031723627 (it also is my favourite
> > > one).
> > 
> > ho hum, I could live with that ;)
> > 
> > Would it make sense to turn it into something more general?  Instead of
> > "tasks_frozen/processes_are_frozen()", present it as
> > "oom_killer_disabled/oom_killer_is_disabled()"?
> > 
> > That would invite other subsystems to use it, if they want to.  Which
> > might well be a bad thing on their behalf, hard to say..
> 
> I chose the names this way because the variable is defined in the freezer code.
> 
> Alternatively, I can define one in page_alloc.c, add [disable|enable]_oom_killer()
> for manipulating it and call them from the freezer code.  Do you think that
> would be better?

The choice is:

a) put a general oom-killer interface function into the oom-killer
   code, call that from swsusp.

b) put a swsusp-specific change into the oom-killer, call that from swsusp.


>From a cleanliess POV, a) is way better.  But it does need to be a
general function!  If there's some hidden requirement which only makes
the function applicable to swsusp, such as "all tasks must be frozen" then
we'd be kidding ourselves by making it general-looking.

I have a bad feeling that after one week and 12^17 emails, we're back
to your original patch :)
