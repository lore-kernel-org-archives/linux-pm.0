From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Wed, 25 Jul 2007 14:28:38 +0200
Message-ID: <20070725122838.GG1895@elf.ucw.cz>
References: <200707251401.48340.rjw@sisk.pl> <200707251409.40592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707251409.40592.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> Use the observation that try_to_freeze() need not loop while waiting for the
> freezing tasks to enter the refrigerator and make it use a wait queue.
> 
> The idea is that after sending freeze requests to the tasks regarded as
> freezable try_to_freeze() can go to sleep and wait until at least one task
> enters the refrigerator.  The first task that does it wakes up try_to_freeze()
> and the procedure is repeated.  If the refrigerator is not entered by any tasks
> before TIMEOUT expires, try_to_freeze() increases the counter of expired
> timeouts and sends freeze requests to the remaining tasks.  If the number of
> expired timeouts becomes greater than MAX_WAITS, the freezing of tasks fails
> (the counter of expired timeouts is reset whenever a task enters the
> refrigerator).
> 
> This way, try_to_freeze() doesn't occupy the CPU unnecessarily when some
> freezing tasks are waiting for I/O to complete and we have more fine grained
> control over the freezing procedure.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>
> ---
>  kernel/power/process.c |   70 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 11 deletions(-)

But is this really neccessary? It is not like the freezing phase of
suspend is particulary time critical, and this only makes it more
complex. We do not poll the task _that_ often that this matters,
right?

Or have you seen some speedups on some particulary perverse workload?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
