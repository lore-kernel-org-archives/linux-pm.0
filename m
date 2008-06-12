From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH - supplement] PM: Remove remaining obsolete
	definitions from pm.h (was: Re: [PATCH 0/4] Remove some
	obsolete PM stuff)
Date: Thu, 12 Jun 2008 15:13:47 +0200
Message-ID: <20080612131347.GE5455__34348.9203406081$1213276699$gmane$org@ucw.cz>
References: <200806121025.24668.rjw@sisk.pl> <200806121126.27862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806121126.27862.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-06-12 11:26:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove the remaining obsolete definitions from
> include/linux/pm.h and move the definitions of PM_SUSPEND and
> PM_RESUME to the header of h3600 which is the only user of them.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.. and thanks for doing the cleanups.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
