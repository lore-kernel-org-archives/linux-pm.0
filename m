From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] PM: make wakeup flags available whenever
	CONFIG_PM	is set
Date: Thu, 13 Mar 2008 10:31:28 +0100
Message-ID: <20080313093128.GC24027__46709.1511739001$1205403831$gmane$org@elf.ucw.cz>
References: <200803120055.25885.rjw@sisk.pl> <200803120101.48805.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803120101.48805.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-03-12 01:01:47, Rafael J. Wysocki wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> The various wakeup flags and their accessor macros in struct
> dev_pm_info should be available whenever CONFIG_PM is enabled, not
> just when CONFIG_PM_SLEEP is on.  Otherwise remote wakeup won't always
> be configurable for runtime power management.  This patch (as1056)
> fixes the oversight.
> 
> [rjw: rebased the patch on top of the previous two.]
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: David Brownell <david-b@pacbell.net>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. But I wonder if we should reduce ammount of config options we
have in power management. All those combinations are hard to test...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
