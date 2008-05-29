From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Thu, 29 May 2008 16:06:32 -0700
Message-ID: <20080529160632.816e1720.akpm@linux-foundation.org>
References: <200805291333.42057.david-b@pacbell.net>
	<200805292301.42244.rjw@sisk.pl>
	<200805291426.18404.david-b@pacbell.net>
	<200805292329.48896.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805292329.48896.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thu, 29 May 2008 23:29:48 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday, 29 of May 2008, David Brownell wrote:
> > On Thursday 29 May 2008, Rafael J. Wysocki wrote:
> > > Two questions:
> > > 
> > > 1) How is it related to the analogous patch in the Ingo's tree?
> > 
> > AFAIK -- just that it's an updated version.  Comments, some
> > code flow, but mostly having the "test_suspend=mode" parameter
> > default to "safe -- no testing" and allows the choice of modes.
> > 
> > 
> > > 2) Does it apply to the current linux-next?
> > 
> > No idea.
> 
> Could you check, please?  The previous version didn't.
> 

There's just one trivial reject against the PCI tree's
pm-introduce-new-top-level-suspend-and-hibernation-callbacks:

***************
*** 293,299 ****
  	if (suspend_ops->finish)
  		suspend_ops->finish();
   Resume_devices:
  	device_resume();
   Resume_console:
  	resume_console();
   Close:
--- 342,350 ----
  	if (suspend_ops->finish)
  		suspend_ops->finish();
   Resume_devices:
+ 	suspend_test_start();
  	device_resume();
+ 	suspend_test_finish("resume devices");
   Resume_console:
  	resume_console();
   Close:
