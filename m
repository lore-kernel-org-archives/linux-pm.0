From: Pavel Machek <pavel@ucw.cz>
Subject: Re: document open(/dev/snapshot) sideeffects -- was Re:
 syncing the disks when entering sleep
Date: Sat, 24 Apr 2010 07:42:25 +0200
Message-ID: <20100424054224.GB2290__38693.2651781992$1272087890$gmane$org@elf.ucw.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001281143.08993.rjw@sisk.pl> <20100405063852.GA1924@elf.ucw.cz>
	<201004232028.56005.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004232028.56005.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2010-04-23 20:28:55, Rafael J. Wysocki wrote:
> On Monday 05 April 2010, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Please note that merely _opening_ /dev/snapshot has side effects, so that's
> > > > > not just "three ioctls".
> > > > 
> > > > I search Doc*/power/userland-swsusp.txt, and could not find mentions
> > > > of sideeffects. Perhaps that should be fixed?
> > > 
> > > Please feel free to make the docs more complete, then.
> > 
> > Yes, something like this?
> 
> Yes, looks reasonable.
> 
> I've applied it to suspend-2.6/linux-next (added a changelog).

Thanks!
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
