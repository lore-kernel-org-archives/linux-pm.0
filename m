From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting
	for	frozen	filesystems.
Date: Fri, 31 Oct 2008 22:28:04 +1100
Message-ID: <1225452484.6574.35.camel__21136.5586183549$1225452744$gmane$org@nigel-laptop>
References: <Pine.LNX.4.44L0.0810300955020.2401-100000@iolanthe.rowland.org>
	<1225403060.6574.10.camel@nigel-laptop>
	<E1Kvpgo-00045l-GU@pomaz-ex.szeredi.hu>
	<1225444253.6574.21.camel@nigel-laptop>
	<E1Kvq72-00049W-O1@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1Kvq72-00049W-O1@pomaz-ex.szeredi.hu>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi again.

On Fri, 2008-10-31 at 10:16 +0100, Miklos Szeredi wrote:
> On Fri, 31 Oct 2008, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Fri, 2008-10-31 at 09:49 +0100, Miklos Szeredi wrote:
> > > On Fri, 31 Oct 2008, Nigel Cunningham wrote:
> > > > I'm not sure that's true. You see, I'm thinking of this as not that
> > > > different to the problem of unmounting filesystems. There, too, we need
> > > > to unmount in a particular order, and let transactions on each
> > > > filesystem stop cleanly before we can unmount them. Even if there are
> > > > differences, perhaps looking at how we handle unmounting will help with
> > > > handling freezing.
> > > 
> > > There's nothing magic about umount, it just uses a refcount on the fs.
> > > 
> > > But umount changes the namespace, that's the big difference.  For
> > > example if a process is accessing path P which has a component inside
> > > the mount, it _will_ get different results before and after the
> > > umount.  This is not acceptable for freezing.
> > > 
> > > For freezing to work with such a refcounting scheme, we'd have to
> > > count _future_ uses of the fs as well, not just current ones, which is
> > > obviously impossible.
> > 
> > I must be missing something. If you're freezing future users of the
> > filesystem before they can start anything new, doesn't that deal with
> > this problem?
> 
> How do you determine which are the future users?

You don't. You just use FUSE_MIGHT_FREEZE to stop them before they take
locks that might cause problems. So my suggestion is:

1) Stop new requests at FUSE_MIGHT_FREEZE
2) Handle existing requests by using freezer_do_not_count in
request_send and request_send_nowait before the spin_lock and
freezer_count after the spin_unlock.

With #2, we don't need to care about whether the request is completed
before freezing completes or post-resume.

If the userspace process tries to use an already frozen fuse filesystem
and gets frozen, that's okay because we'll sit waiting for an answer,
not be counted by the freezer and so not contribute to any failure to
freeze processes.

If the userspace process completes its work, we'll either get caught at
the freezer_count (if we've already been told to freeze) or be gotten
later, after exiting the fuse code.

Regards,

Nigel
