From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 2/4] PM: Move definition of
	struct pm_ops to suspend.h
Date: Mon, 25 Jun 2007 21:33:27 +0200
Message-ID: <20070625193327.GB2008__49574.4615830064$1182800186$gmane$org@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706242241.39283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706242241.39283.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-06-24 22:41:38, Rafael J. Wysocki wrote:
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
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
