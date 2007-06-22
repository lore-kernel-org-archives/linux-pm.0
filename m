From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RC][PATCH -mm] PM: Prevent frozen user mode helpers
	from failing the freezing of tasks
Date: Fri, 22 Jun 2007 21:07:50 +0000
Message-ID: <20070622210750.GA4267__33122.5277543583$1182546527$gmane$org@ucw.cz>
References: <200706221647.50509.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706221647.50509.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> At present, if a user mode helper is running while usermodehelper_pm_callback()
> is executed, the helper may be frozen and the completion in
> call_usermodehelper_exec() won't be completed until user space processes are
> thawed.  As a result, the freezing of kernel threads may fail, which is not
> desirable.
> 
> Prevent this from happening by introducing a counter of running user mode
> helpers and allowing usermodehelper_pm_callback() to succeed for
> action = PM_HIBERNATION_PREPARE or action = PM_SUSPEND_PREPARE only if there
> are no helpers running.  [Namely, usermodehelper_pm_callback() waits for at most
> RUNNING_HELPERS_TIMEOUT for the number of running helpers to become zero and
> fails if that doesn't happen.]
> 
> Special thanks to Uli Luckas <u.luckas@road.de> for reviewing the previous
> versions of this patch and for very useful comments.
...
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Eh, not sure this header is worth anything. Sometimes I'm lazy and
stop when I see first problem.

>  	switch (action) {
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
>  		usermodehelper_disabled = 1;
> -		return NOTIFY_OK;
> +		retval = wait_event_timeout(running_helpers_waitq,
> +					atomic_read(&running_helpers) == 0,

Are you sure here? What happens when atomic variable changes between
the atomic_read and the function call?
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
