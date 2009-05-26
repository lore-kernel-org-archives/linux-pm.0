From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 11:19:40 +0200
Message-ID: <20090526091940.GA29867__38306.0807981112$1243329707$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905252343.23744.rjw@sisk.pl>
	<200905260045.33902.oliver@neukum.org>
	<200905260058.54482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905260058.54482.rjw@sisk.pl>
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

> > If you really have drivers that have exceptionally large memory requirements
> > (eg. you need to copy video ram), you should tell the system through struct
> > driver and do accounting at probe and removal of devices.
> 
> Or perhaps the drivers should allocate memory from a PM notifier (which is
> called before the freezing of tasks) to avoid the problem?

Yes, that's how it should work for big allocations.

For small allocations... I still believe we should free a bit of
memory for s2ram so that small allocations can be done without
problems.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
