From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC][PATCH 2/2] Freezer: Try to handle killable
	tasks
Date: Wed, 7 May 2008 07:53:34 -0600
Message-ID: <20080507135333.GS19219__23781.5570588738$1210168602$gmane$org@parisc-linux.org>
References: <200805070003.56387.rjw@sisk.pl> <200805070007.56998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805070007.56998.rjw@sisk.pl>
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
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Liam Howlett <howlett@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, May 07, 2008 at 12:07:55AM +0200, Rafael J. Wysocki wrote:
> The introduction of TASK_KILLABLE allows the freezer to work in some situation
> that it could not handle before.
> 
> Make the freezer handle killable tasks and add try_to_freeze() in some places
> where it is safe to freeze a (killable) task.  Introduce the
> wait_event_killable_freezable() macro to be used wherever the freezing of
> a waiting killable task is desirable.

Why do you say that TASK_KILLABLE allows the freezer to work in some
situations where it couldn't before?  If something's using one of the
killable functions, it means that it knows how to clean up and unwind
gracefully if the task receives a fatal signal.  I don't understand what
connection there is to the freezer.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
