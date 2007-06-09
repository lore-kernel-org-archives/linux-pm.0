From: Pavel Machek <pavel@ucw.cz>
Subject: Re: spontaneous second suspend-to-RAM
Date: Sat, 9 Jun 2007 15:14:33 +0200
Message-ID: <20070609131431.GA3397@elf.ucw.cz>
References: <f48tuv$q57$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f48tuv$q57$1@sea.gmane.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I'm experiencing a spontaneous suspend to RAM occasionally. It happens about
> thirty seconds after resuming from RAM. It happened a few times today. I'm
> not sure if it's a kernel problem or something else, possibly kpowersave
> which I use to suspend, but I haven't upgraded that in a while. (kpowersave
> uses s2ram.)
> 
> This is kernel 2.6.22-rc4 (x86_64) with Debian on a Thinkpad R60, Intel Core
> 2 Duo, and uswsusp.

Try reproducing it in init=/bin/bash to see if it is userspace or
kernel problem. Or just kill -9 -1 after resume ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
