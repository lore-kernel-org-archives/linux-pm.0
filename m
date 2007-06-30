From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 4/9] PM: Rename struct pm_ops and
	related things
Date: Sun, 1 Jul 2007 01:04:52 +0200
Message-ID: <20070630230452.GC1855@elf.ucw.cz>
References: <200706302257.17556.rjw@sisk.pl> <200706302303.59457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706302303.59457.rjw@sisk.pl>
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

On Sat 2007-06-30 23:03:57, Rafael J. Wysocki wrote:
> [Previous version of this was acked by Pavel, but I've updated it since then.]
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The name of 'struct pm_ops' suggests that it is related to the power management
> in general, but in fact it is only related to suspend.  Moreover, its name
> should indicate what this structure is used for, so it seems reasonable to
> change it to 'struct platform_suspend_ops'.  In that case, the name of
> the global variable of this type used by the PM core and the names of related
> functions should be changed accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
