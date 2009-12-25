From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Fri, 25 Dec 2009 18:09:44 +0100
Message-ID: <20091225170943.GB1581__35382.1428762332$1261761068$gmane$org@ucw.cz>
References: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
	<Pine.LNX.4.44L0.0912091051450.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091051450.4120-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > That's partly why I realy did suggest that we do the async stuff purely in 
> > the USB layer, rather than try to put it deeper in the device layer. And 
> > if we do support it "natively" in the device layer like Rafael's latest 
> > patch, I still think we should be very very nervous about making devices 
> > async unless there is a measured - and very noticeable - advantage.
> 
> Agreed.  Arjan's measurements indicated that USB was one of the biggest
> offenders; everything else other than the PS/2 mouse was much faster.  
> Given these results there isn't much incentive to do anything else
> asynchronously.
> 
> (However other devices not present on Arjan's machine may be a
> different story.  Spinning up multiple external disks is a good example 
> -- although here it may be necessary for the driver to take charge, 
> because spinning up a disk requires a lot of power and doing too many 
> of them at the same time could be bad.)

Well, system would better be able to supply enough current... because
usb disks auto-sleep on their own, and then something like async ls -l
/*/* would kill your machine...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
