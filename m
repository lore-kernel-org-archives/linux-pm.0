From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.24-rc7] remove obsolete
	/sys/devices/.../power/state docs
Date: Wed, 9 Jan 2008 23:48:30 +0100
Message-ID: <20080109224830.GA19545__16059.84171988$1199919500$gmane$org@elf.ucw.cz>
References: <200801091212.24386.david-b@pacbell.net>
	<200801092255.09841.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801092255.09841.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-01-09 22:55:09, Rafael J. Wysocki wrote:
> On Wednesday, 9 of January 2008, David Brownell wrote:
> > The /sys/devices/.../power/state files have been gone for a while
> > now, but I just noticed some documentation that still refers to
> > them.  (Fortunately described as DEPRECATED and WILL REMOVE).
> > 
> > Time to remove that obsolete documentation too ...
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
