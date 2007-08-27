From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Q: suspend_late() semantics
Date: Mon, 27 Aug 2007 12:02:03 +0200
Message-ID: <20070827100203.GC1972@elf.ucw.cz>
References: <Pine.LNX.4.60.0708260131080.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0708260131080.3809@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2007-08-26 01:40:24, Guennadi Liakhovetski wrote:
> Hi
> 
> trying to understand when suspend_late gets called, I just wasn't quite 
> sure if I got the following points right:
> 
> 1. seems to be a typo in the comment above 
> drivers/base/power/suspend.c::device_power_down() - the function walks the 
> dpm_off list and not the dpm_off_irq list, as claimed in the comment

Can you send the diff to akpm?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
