From: Pavel Machek <pavel@ucw.cz>
Subject: sysrq-t dumps of s2ram/fuse deadlock (was Re: [PATCH]
	Remove process freezer from suspend to RAM pathway)
Date: Mon, 9 Jul 2007 13:29:05 +0000
Message-ID: <20070709132905.GA5212__33891.7372785092$1184159789$gmane$org@ucw.cz>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031456.36027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707031456.36027.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

Can we get them? They are neccessary for debugging 'what in suspend
calls fuse' problem. And yes, that problem is there even when you
remove freezer.

Matthew, you seem to be the only one able to produce them...
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
