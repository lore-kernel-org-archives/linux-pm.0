From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 5/5] b43: Avoid unregistering device
	objects during suspend
Date: Fri, 25 Jan 2008 22:16:18 +0100
Message-ID: <20080125211618.GA2261__26044.2741019235$1201295875$gmane$org@elf.ucw.cz>
References: <20080125074746.GC4134@ucw.cz>
	<Pine.LNX.4.44L0.0801250955210.4190-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0801250955210.4190-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, bcm43xx-dev@lists.berlios.de, Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-01-25 09:58:00, Alan Stern wrote:
> On Fri, 25 Jan 2008, Pavel Machek wrote:
> 
> > Maybe we should have global suspend_in_progress (or maybe system_state
> > == suspending?) and automatically switch to schedule_removal() while
> > it is set?
> 
> :-)  There was a time a couple of years ago when you objected violently 
> to the mere suggestion of such a global variable!

Lets say I was young at stupid...? ;-).

> It's not a bad idea IMO.  But if it does get implemented, a global
> function would be better than a global variable.  It would provide
> more encapsulation.

Agreed.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
