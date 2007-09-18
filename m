From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 4/5] Hibernation: Correct definitions of
	some ioctls (rev. 2)
Date: Tue, 18 Sep 2007 10:50:49 +0200
Message-ID: <20070918085049.GB27108__24524.9195643284$1190105515$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200709092257.16085.rjw@sisk.pl> <200709092312.52889.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709092312.52889.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Three ioctl numbers belonging to the hibernation userland interface,
> SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_SET_IMAGE_SIZE, SNAPSHOT_AVAIL_SWAP,
> SNAPSHOT_GET_SWAP_PAGE, are defined in a wrong way (eg. not portable).  Provide
> new ioctl numbers for these ioctls and mark the existing ones as deprecated.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
