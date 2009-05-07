From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] TuxOnIce
Date: Thu, 7 May 2009 23:51:12 +0200
Message-ID: <20090507215112.GC14611__7193.1961262182$1241733283$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz> <200905071942.54936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905071942.54936.rjw@sisk.pl>
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

On Thu 2009-05-07 19:42:54, Rafael J. Wysocki wrote:
> On Thursday 07 May 2009, Pavel Machek wrote:
> > Hi!
> > 
> > > I'd like to submit TuxOnIce for review, with a view to seeking to get it
> > > merged, perhaps in 2.6.31 or .32 (depending upon what needs work before
> > > it can be merged) and the willingness of those who matter.
...
> > To summarise disadvantages:
> > 
> > - only core has 8000 LoC
> > - it does stuff that can be easily done in userspace
> >      (and that todays distros _do_ in userspace).
> > - it duplicates uswsusp functionality.
> > - compared to [u]swsusp, it received little testing
> 
> Actually, I see advantages of working together versus fighting flame wars.
> Please stop that, I'm not going to take part in it this time.

Ok, so what do you propose? Merging tuxonice into 2.6.32, resulting in
having swsusp,uswsusp *and* tuxonice to maintain? I hope not.

If we are talking about improving mainline to allow tuxonice
functionality... then yes, that sounds reasonable.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
