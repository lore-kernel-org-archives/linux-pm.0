From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Tue, 24 Apr 2007 20:45:56 -0700
Message-ID: <200704242045.56409.david-b@pacbell.net>
References: <1176980411.6141.83.camel@johannes.berg>
	<1177422695.3528.24.camel@johannes.berg>
	<20070424181615.GB15920@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070424181615.GB15920@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 April 2007, Pavel Machek wrote:
> Hi!
> 
> > > > This is a very straightforward point.  A function that's
> > > > called on non-S2RAM paths shouldn't be named as if it's
> > > > only for S2RAM.
> > > 
> > > And the function that's called for s2ram+standby should not be named
> > > as if it's also for swsusp...
> > > 
> > > > Ergo, those two functions are misnamed.  End of story.
> > > 
> > > ...which is not only misnamed, it is also actively confusing. (And
> > > someone _will_ ask me to call that function from swsusp, too.
> > > 
> > > ...maybe we could solve it with a big fat comment?
> > 
> > So how about we don't call them s2ram which is confusing since s2ram is
> > only one suspend state we support but call them suspend as David
> > originally proposed and add a comment that since suspend-to-disk isn't a
> > true suspend state, they are not called there?
> 
> calling them ..._suspend_... and explaining in comment is probably ok.

Yah, I'm fine with that too.



> > Has anybody figured out if (and if yes, where) we should add them to
> > some header file?
> 
> include/linux/pm.h is probably the right place.
> 
> Feel free to add my acked-by: and send it to akpm.
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
