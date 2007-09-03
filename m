From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 5/5] Hibernation: Introduce exportable
	suspend ioctls header
Date: Mon, 3 Sep 2007 03:29:34 +0000
Message-ID: <20070903032934.GI21721@ucw.cz>
References: <200709022315.59652.rjw@sisk.pl> <200709022328.20720.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709022328.20720.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the definitions of hibernation ioctls to a separate header file in
> include/linux, which can be exported to the user space.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK, but this depends on previous patches that need fixes. Perhaps
this should be moved to the begging of series?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
