From: Pavel Machek <pavel@suse.cz>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Fri, 9 Jan 2009 11:36:58 +0100
Message-ID: <20090109103658.GE3396__6997.24504161185$1231497519$gmane$org@elf.ucw.cz>
References: <200901080835.39639.rjw@sisk.pl>
	<200901081748.58962.oliver@neukum.org>
	<20090109101840.GD3396@elf.ucw.cz>
	<200901091126.57094.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901091126.57094.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-01-09 11:26:55, Oliver Neukum wrote:
> Am Friday 09 January 2009 11:18:41 schrieb Pavel Machek:
> > laptops normally wake up lid open... (and you still have a
> > powerbutton; plus I'm not aware of any laptops with usb keyboard --
> > are apples crazy enough to do that?)
> 
> Yes, they are. Do they wake if you hit the power button or close and
> reopen the lid? If so, I am satisfied and have no problem with reverting.

I think so, yes.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
