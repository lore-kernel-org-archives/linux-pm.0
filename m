From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Remove destroy_suspended_device()
Date: Mon, 24 Mar 2008 16:57:35 +0100
Message-ID: <20080324155735.GA4069__40376.5167728581$1206374621$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200803232028.25611.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803232028.25611.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Buesch <mb@bu3sch.de>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> After 2.6.24 there was a plan to make the PM core acquire all device
> semaphores during a suspend/hibernation to protect itself from
> concurrent operations involving device objects.  That proved to be
> too heavy-handed and we found a better way to achieve the goal, but
> before it happened, we had introduced the functions
> device_pm_schedule_removal() and destroy_suspended_device() to allow
> drivers to "safely" destroy a suspended device and we had adapted some
> drivers to use them.  Now that these functions are no longer necessary,
> it seems reasonable to remove them and modify their users to use the
> normal device unregistration instead.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
