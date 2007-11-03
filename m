From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Add PM_RESTORE_PREPARE and
	PM_POST_RESTORE notifiers
Date: Sat, 3 Nov 2007 19:22:06 +0100
Message-ID: <20071103182206.GB13202__12660.6593760245$1194114179$gmane$org@elf.ucw.cz>
References: <200711012347.44662.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711012347.44662.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-11-01 23:47:43, Rafael J. Wysocki wrote:
> [Len, please add to the suspend branch.]
> ---
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> This patch (as1006) adds PM_RESTORE_PREPARE and PM_POST_RESTORE
> notifiers to the PM core, to be used in analogy with the existing
> PM_HIBERNATION_PREPARE and PM_POST_HIBERNATION notifiers.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Nigel Cunningham <nigel@nigel.suspend2.net>
> Signed-off-by: "Rafael J. Wysocki" <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
