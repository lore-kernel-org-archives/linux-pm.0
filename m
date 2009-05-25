From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 14:43:58 +0200
Message-ID: <20090525124358.GB13446__45028.5249426544$1243255533$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090046.21282.rjw@sisk.pl>
	<1241825408.19600.384.camel@nigel-laptop>
	<200905090143.10980.rjw@sisk.pl>
	<1243245907.16743.101.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1243245907.16743.101.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> Oh, before I forget to mention and you ask - how to know what allowance
> for the drivers? I use a sysfs entry - the user then just needs to see
> what's needed on their first attempt, set up a means of putting that
> value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> then forget about it.

I do believe needed ammount of memory can differ between between
different suspend attempts. I'd say difference between no X, X w/ 3D,
X w/ active 3D could be significant.

Plus... swsusp gets without configuring that, and I'd prefer as little
tunables as possible. (In swsusp case, 4MB is reserved for drivers,
and it is a bug if they need more).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
