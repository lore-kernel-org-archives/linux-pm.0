From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 3/4] PM: Rename struct pm_ops
	and related things
Date: Mon, 25 Jun 2007 21:34:54 +0200
Message-ID: <20070625193454.GC2008__10304.495067294$1182800520$gmane$org@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706242242.47573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706242242.47573.rjw@sisk.pl>
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

On Sun 2007-06-24 22:42:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The name of 'struct pm_ops' suggests that it is related to the power management
> in general, but in fact it is only related to suspend.  Moreover, its name
> should indicate what this structure is used for, so it seems reasonable to
> change it to 'struct platform_suspend_operations'.  In that case, the name of
> the global variable of this type used by the PM core and the names of related
> functions should be changed accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
