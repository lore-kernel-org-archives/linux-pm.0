From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Fri, 31 Oct 2008 09:49:06 +0100
Message-ID: <E1Kvpgo-00045l-GU__37718.2294767865$1225445287$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810300955020.2401-100000@iolanthe.rowland.org>
	<1225403060.6574.10.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225403060.6574.10.camel@nigel-laptop> (message from Nigel
	Cunningham on Fri, 31 Oct 2008 08:44:20 +1100)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ncunningham@crca.org.au
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Fri, 31 Oct 2008, Nigel Cunningham wrote:
> I'm not sure that's true. You see, I'm thinking of this as not that
> different to the problem of unmounting filesystems. There, too, we need
> to unmount in a particular order, and let transactions on each
> filesystem stop cleanly before we can unmount them. Even if there are
> differences, perhaps looking at how we handle unmounting will help with
> handling freezing.

There's nothing magic about umount, it just uses a refcount on the fs.

But umount changes the namespace, that's the big difference.  For
example if a process is accessing path P which has a component inside
the mount, it _will_ get different results before and after the
umount.  This is not acceptable for freezing.

For freezing to work with such a refcounting scheme, we'd have to
count _future_ uses of the fs as well, not just current ones, which is
obviously impossible.

Miklos
