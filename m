From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Introduce PM_EVENT_HIBERNATE (was: Re:
	i915 hibernation patch (was: Re: 2.6.25-rc2 System no longer ...))
Date: Sun, 24 Feb 2008 09:29:18 +0100
Message-ID: <20080224082917.GA4784__11849.9341457666$1203841961$gmane$org@ucw.cz>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
	<b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09@mail.gmail.com>
	<200802231913.27592.rjw@sisk.pl>
	<alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Romano Giannetti <romano@dea.icai.upcomillas.es>, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Thanks, applied. 
> 
> With this, I also find that I dislike the use of suspend/resume for 
> freezing for STD a lot less. It's still too easy to get confused, but at 
> least now drivers always have total knowledge about what is really going 
> on. I'd not like this interface as a driver writer, but now it's not 
> fundamentally broken any more, just slightly confusing.

Heh, thanks :-).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
