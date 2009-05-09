From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 15:27:11 +0200
Message-ID: <20090509132711.GD10859__5529.40819548002$1241875776$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905081611.41865.rjw@sisk.pl>
	<1241819569.19600.281.camel@nigel-laptop>
	<200905090046.21282.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905090046.21282.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > And we have different ideas about how things should be done. Userspace
> > vs kernel space. Providing tuning knobs vs not. And so on.
> 
> This isn't _that_ important.  Actually, I'm not against an entirely in-kernel
> solution, as there are some clear benefits of doing it this way.  We only
> need to be careful enough not to break the existing setups.

Would you elaborate?

I would really hate to put progressbar painting into kernel; and if
that's in userspace, we can do compression/encryption there too as
well....
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
