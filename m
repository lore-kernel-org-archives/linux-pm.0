From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Sun, 4 Nov 2007 19:38:37 +0100
Message-ID: <20071104183837.GB4065@elf.ucw.cz>
References: <200711041459.23082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711041459.23082.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-11-04 14:59:22, Rafael J. Wysocki wrote:
> [Len, please add this patch to the suspend branch, thanks.]
> ---
> From: Johannes Berg <johannes@sipsolutions.net>
> 
> Lockdep reports a circular locking dependency in the hibernate code
> because
>  - during system boot hibernate code (from an initcall) locks pm_mutex
>    and then a sysfs buffer mutex via name_to_dev_t
>  - during regular operation hibernate code locks pm_mutex under a
>    sysfs buffer mutex because it's called from sysfs methods.
> 
> The deadlock can never happen because during initcall invocation nothing
> can write to sysfs yet. This removes the lockdep report by marking the
> initcall locking as being in a different class.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
