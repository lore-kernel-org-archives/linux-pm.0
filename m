From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -next] PM: Simplify the new
	suspend/hibernation	framework for devices
Date: Thu, 9 Oct 2008 19:12:52 +0200
Message-ID: <20081009171252.GC1370__28113.7581369423$1223572854$gmane$org@ucw.cz>
References: <200810060055.07601.rjw@sisk.pl> <200810062246.06654.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810062246.06654.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-10-06 22:46:05, Rafael J. Wysocki wrote:
> On Monday, 6 of October 2008, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > I promised at the KS that I would simplify the new suspend/hibernation
> > framework for devices to avoid the confusion with two types of PM
> > operations and pointers to PM operations from too many places.
> > 
> > The appended patch is intended for this purpose.  Unfortunately, I can't
> > split it into subsystem-related patches, because compilation would be broken
> > between them.
> > 
> > The patch applies to linux-next, but it's trivial to make it apply to the
> > mainline.  It's been compiled on x86 (both 32-bit and 64-bit) and tested
> > on hp nx6325, doesn't appear to break anything.
> 
> This one had a checkpatch.pl problem, sorry for that.  Updated patch is
> appended.

Seems ok to me. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
