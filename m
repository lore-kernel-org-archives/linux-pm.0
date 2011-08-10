From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM / hibernate xfs lock up / xfs_reclaim_inodes_ag
Date: Wed, 10 Aug 2011 23:43:27 +0200
Message-ID: <20110810214327.GA9320@atrey.karlin.mff.cuni.cz>
References: <4E1C70AD.1010101@u-club.de> <201107262228.12099.rjw@sisk.pl>
	<20110727004543.GE8048@dastard> <201107271135.13297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107271135.13297.rjw@sisk.pl>
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
Cc: Christoph <cr2005@u-club.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Why don't you simply submit a patch to do that?
> > 
> > a) I don't know how to test suspend/hibernate
> > b) I don't have any hardware I can test it on.

hibernation should work on any hardware. Just add cmdline parameter
resume=<your swap> and use echo disk > /sys/power/state.

suspend is supported on most PCs, and certainly on any notebook. Just
echo mem > /sys/power/state.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
