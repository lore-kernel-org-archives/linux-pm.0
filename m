From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RC][PATCH] PM: Remove code duplication between
	main.c and user.c
Date: Fri, 22 Jun 2007 21:02:15 +0000
Message-ID: <20070622210215.GA4242__7521.30335099554$1182546195$gmane$org@ucw.cz>
References: <200706221650.56791.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706221650.56791.rjw@sisk.pl>
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
> The SNAPSHOT_S2RAM ioctl code is outdated and it should not duplicate the
> suspend code in kernel/power/main.c.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
