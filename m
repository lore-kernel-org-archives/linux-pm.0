From: Pavel Machek <pavel@suse.cz>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Sun, 9 Nov 2008 14:44:22 +0100
Message-ID: <20081109134422.GA1730__22138.7383448475$1226239010$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
	<200810292211.49021.rjw@sisk.pl>
	<1225316715.18786.1.camel@nigel-laptop>
	<200810292307.26945.rjw@sisk.pl>
	<E1KvKql-0000dC-3M@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1KvKql-0000dC-3M@pomaz-ex.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-10-30 00:53:19, Miklos Szeredi wrote:
> On Wed, 29 Oct 2008, Rafael J. Wysocki wrote:
> > In any case, the freezing of user space seems to be much simpler
> > than modifying all drivers to add suspend synchronization.
> 
> As I mentioned, we don't _have_ to modify all drivers.  It could start
> out by just modifying syscalls that result in calls to drivers.  That
> would be a 10-liner patch.

If you can solve current freezer vs. fuse in 10 lines, that would be
useful...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
