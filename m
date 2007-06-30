From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/9] PM: Move definition of struct
	pm_ops to suspend.h
Date: Sun, 1 Jul 2007 01:04:14 +0200
Message-ID: <20070630230414.GB1855@elf.ucw.cz>
References: <200706302257.17556.rjw@sisk.pl> <200706302301.57528.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706302301.57528.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-06-30 23:01:55, Rafael J. Wysocki wrote:
> [Previous version of this was acked by Pavel, but I've updated it since then.]
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the definition of 'struct pm_ops' and related functions from <linux/pm.h>
> to <linux/suspend.h> .
> 
> There are, at least, the following reasons to do that:
> * 'struct pm_ops' is specifically related to suspend and not to the power
>   management in general.
> * As long as 'struct pm_ops' is defined in <linux/pm.h>, any modification of it
>   causes the entire kernel to be recompiled, which is unnecessary and annoying.
> * Some suspend-related features are already defined in <linux/suspend.h>, so it
>   is logical to move the definition of 'struct pm_ops' into there.
> * 'struct hibernation_ops', being the hibernation-related counterpart of
>   'struct pm_ops', is defined in <linux/suspend.h> .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
