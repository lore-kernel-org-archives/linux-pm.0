From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Mon, 27 Oct 2008 12:12:25 +0100
Message-ID: <E1KuQ1J-0002Vw-9Q__42145.8778357648$1225119225$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810262101.08822.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810262101.08822.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Oct 2008, Rafael J. Wysocki wrote:
> On Saturday, 25 of October 2008, Nigel Cunningham wrote:
> > While working on freezing fuse filesystems, I found that if a filesystem
> > is frozen when we try to freeze processes, freezing can fail because
> > threads are waiting in vfs_check_frozen for the filesystem to be thawed.
> > We should thus not count such threads.
> > 
> > The check will be safe if a filesystem is thawed while we're freezing
> > processes because filesystem thaws are only invoked from userspace. Any
> > waiting processes will be woken and frozen prior to us completing the
> > freezing of userspace (the caller invoking the filesystem thaw will be
> > freezing) or - in the worst case - together with kernel threads.

The description is missing some details: why is the filesystem frozen
before suspend?  AFAICS this can happen when DM calls bdev_freeze() on
the device before the task freezing begins.  Is this the case?

Also, while the patch might solve some of the symptoms of the fuse
vs. process freezer interaction, it will not fully fix that problem.
As such it's just a hack to hide the problem, making it less likely to
appear.

So I'm not at all conviced about this patch.

Thanks,
Miklos
