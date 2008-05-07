From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] Freezer: Try to handle killable
	tasks
Date: Wed, 7 May 2008 20:41:19 +0200
Message-ID: <200805072041.20210.rjw__33179.0332370021$1210185877$gmane$org@sisk.pl>
References: <200805070003.56387.rjw@sisk.pl> <200805070007.56998.rjw@sisk.pl>
	<20080507135333.GS19219@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080507135333.GS19219@parisc-linux.org>
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
To: Matthew Wilcox <matthew@wil.cx>
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Liam Howlett <howlett@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of May 2008, Matthew Wilcox wrote:
> On Wed, May 07, 2008 at 12:07:55AM +0200, Rafael J. Wysocki wrote:
> > The introduction of TASK_KILLABLE allows the freezer to work in some situation
> > that it could not handle before.
> > 
> > Make the freezer handle killable tasks and add try_to_freeze() in some places
> > where it is safe to freeze a (killable) task.  Introduce the
> > wait_event_killable_freezable() macro to be used wherever the freezing of
> > a waiting killable task is desirable.
> 
> Why do you say that TASK_KILLABLE allows the freezer to work in some
> situations where it couldn't before?  If something's using one of the
> killable functions, it means that it knows how to clean up and unwind
> gracefully if the task receives a fatal signal.  I don't understand what
> connection there is to the freezer.

The reason why we don't freeze uninterruptible tasks is that we don't know
why they are in that state.  If one of tasks is uninterruptible for a
relatively long time, that may indicate a non-recoverable error making it
dangerous to put the system into a sleep state.  If the task is killable,
though, the situation is recoverable.

Thanks,
Rafael
