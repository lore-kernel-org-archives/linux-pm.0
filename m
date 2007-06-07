From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux 2.6.22-rc4
Date: Thu, 7 Jun 2007 23:14:37 +0200
Message-ID: <20070607211437.GA8611__37784.3689559542$1181250956$gmane$org@elf.ucw.cz>
References: <alpine.LFD.0.98.0706042040350.23741@woody.linux-foundation.org>
	<200706071206.06298.gene.heskett@gmail.com>
	<Pine.LNX.4.64.0706071853080.15778@fbirervta.pbzchgretzou.qr>
	<200706071621.00687.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706071621.00687.gene.heskett@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@computergmbh.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Don't know Jan.  nv, the last time I tried that bucket of molasses in january, 
> couldn't drive this card at more than 800x600, and I am used to double that 
> both ways.
> 
> The last time I booted to nv, it took me a week to get all the crap fixed that 
> it overwrote trying to fit the default screens I use while trying to make 
> them fit in an 800x600 window.
> 
> I run 1600x1200, on either an ati card (but the radeon driver quit supporting  
> the r280 chipset according to boot messages, the main reason I bought this 
> nvidia card) or on an older nvidia card that nv was quite happy with.  That 
> card went belly up and took the motherboard with it 2 years ago though.
> 
> Did you miss the comment that it works with a 2.6.21ish kernel?  Everything 
> else being equal.  I will boot to one of them later tonight and test it to 
> make sure its not some update to kde though, and let the list know.

Well, your kernel is tainted with nvidia crap we are not allowed to
debug. Issue is screen blanking. "It worked before" or not is not
really interesting, sorry.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
