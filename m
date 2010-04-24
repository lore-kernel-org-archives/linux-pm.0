From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Sat, 24 Apr 2010 07:39:17 +0200
Message-ID: <20100424053916.GA2290__8781.06509703702$1272087622$gmane$org@elf.ucw.cz>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<20100423084349.GC1573@ucw.cz> <20100424015334.GO14986@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100424015334.GO14986@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Arve Hj??nnev??g <arve@android.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Rafael J. Wysocki
List-Id: linux-pm@vger.kernel.org

On Fri 2010-04-23 21:53:34, tytso@mit.edu wrote:
> On Fri, Apr 23, 2010 at 10:43:49AM +0200, Pavel Machek wrote:
> > > +To create a suspend_blocker from user-space, open the suspend_blocker device:
> > > +    fd = open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> > > +then call:
> > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);
> > 
> > 
> > This seems like very wrong idea -- it uses different ioctl number for
> > each length AFAICT.
> 
> Yep, and there's nothing wrong with that IMHO.  It's a clever use of
> the _IOC encoding scheme.

I'm not sure if "clever" is right word. So what if strlen is in 2GB
range, will macros still work correctly?

Will it be easy for strace to display such ioctls?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
