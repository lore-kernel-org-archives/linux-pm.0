From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Mon, 27 Oct 2008 22:20:27 +1100
Message-ID: <1225106427.26724.5.camel__9422.08692799813$1225106927$gmane$org@nigel-laptop>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810262101.08822.rjw@sisk.pl>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
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

Hi Miklos.

On Mon, 2008-10-27 at 12:12 +0100, Miklos Szeredi wrote:
> On Sun, 26 Oct 2008, Rafael J. Wysocki wrote:
> > On Saturday, 25 of October 2008, Nigel Cunningham wrote:
> > > While working on freezing fuse filesystems, I found that if a filesystem
> > > is frozen when we try to freeze processes, freezing can fail because
> > > threads are waiting in vfs_check_frozen for the filesystem to be thawed.
> > > We should thus not count such threads.
> > > 
> > > The check will be safe if a filesystem is thawed while we're freezing
> > > processes because filesystem thaws are only invoked from userspace. Any
> > > waiting processes will be woken and frozen prior to us completing the
> > > freezing of userspace (the caller invoking the filesystem thaw will be
> > > freezing) or - in the worst case - together with kernel threads.
> 
> The description is missing some details: why is the filesystem frozen
> before suspend?  AFAICS this can happen when DM calls bdev_freeze() on
> the device before the task freezing begins.  Is this the case?

It doesn't matter why a process is sitting in that wait_event call. What
does matter is that one can be there. In the case where I saw it, I was
working on fuse freezing. I don't remember the details, as it's a year
since I made this patch, but I don't think I wasn't using fuse or DM.

> Also, while the patch might solve some of the symptoms of the fuse
> vs. process freezer interaction, it will not fully fix that problem.
> As such it's just a hack to hide the problem, making it less likely to
> appear.

No, it's part of the solution. I haven't posted the full fuse freezing
patch because I thought this could be profitably merged without the rest
of the patch.

Regards,

Nigel
