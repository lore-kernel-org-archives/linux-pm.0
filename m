From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 15:58:20 +0200
Message-ID: <20090509135820.GF10859__44493.2982478805$1241877710$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905082144.57955.bzolnier@gmail.com>
	<1241819971.19600.288.camel@nigel-laptop>
	<200905090105.58243.bzolnier@gmail.com>
	<1241824525.19600.369.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1241824525.19600.369.camel@nigel-laptop>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Instead of new features I would rather see more effort being put into making
> > the _core_ TuxOnIce (I mean patch #8 here) smaller (8 KLOC is still a lot,
> > just to put things into the right perspective the current in-kernel content
> > of kernel/power/ is 5.5 KLOC) and with more documentation inside the code.
> 
> Yeah, but those 2.5k extra lines get you more reliability and extra
> functionality. They're not fat.

If you know about reliability problems in swsusp, please fix them in
separate patch. Hiding the fixes in 8KLOC patch is not nice.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
