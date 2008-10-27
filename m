From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Tue, 28 Oct 2008 09:13:27 +1100
Message-ID: <1225145607.26724.54.camel__37118.7677410946$1225146008$gmane$org@nigel-laptop>
References: <1224886068.6478.21.camel@nigel-laptop>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
	<200810271237.40049.rjw@sisk.pl>
	<1225107607.26724.9.camel@nigel-laptop>
	<E1KuRN4-0002gS-Hq@pomaz-ex.szeredi.hu>
	<1225141168.26724.23.camel@nigel-laptop>
	<E1KuZKt-0003jl-2N@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KuZKt-0003jl-2N@pomaz-ex.szeredi.hu>
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

Hi.

On Mon, 2008-10-27 at 22:09 +0100, Miklos Szeredi wrote:
> On Tue, 28 Oct 2008, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2008-10-27 at 13:38 +0100, Miklos Szeredi wrote:
> > > On Mon, 27 Oct 2008, Nigel Cunningham wrote:
> > > > Hi.
> > > > 
> > > > On Mon, 2008-10-27 at 12:37 +0100, Rafael J. Wysocki wrote:
> > > > > Well, I guess it's better if you post the entire thing so that we can see
> > > > > what the role of the $subject patch is in it, even if this patch finally gets
> > > > > merged separately.
> > > > 
> > > > Ah.. that makes me see how vfs_check_frozen was getting triggered...
> > > > (fs/namei.c, below).
> > > 
> > > Nigel, thanks for the patch, it makes thinks a lot clearer.
> > > 
> > > >From a quick look through the patch it seems to solve a bunch of cases
> > > where new fuse requests during the freezing could cause problems.  But
> > > it doesn't do anything with requests that are already under way when
> > > the freezing starts, which would still result in all the same
> > > problems.
> > > 
> > > Take this scenario:
> > > 
> > >  1) process A does rename("/mnt/fuse/a", "/mnt/fuse/b")
> > >  2) request goes to process B serving the fuse filesystem
> > >  3) filesystems are frozen, no new fuse requests
> > >  4) processes are frozen, let's say B first, then A
> > >  5) freezing A will fail, since it's still waiting for the request to finish
> > 
> > I'll have a look at the code again. I deliberately didn't stop existing
> > requests, but perhaps that's the wrong behaviour.
> > 
> > In the above scenario, process B won't see process A's new request until
> > post-resume if the filesystem is already frozen, so steps 4 & 5 don't
> > happen.
> 
> No, I mean the filesystem is only frozen at 3 not before, so B is
> already processing the request by the time the filesystem gets frozen.
> 
> > Process B will also always be frozen before process A if process
> > A is userspace (most likely in the above scenario) or was mounted after
> > process B. (I've had this patch distributed as is for almost a year,
> > with no problems at all, so I believe I'm right here).
> 
> Both A and B are userspace processes.  The order of freezing userspace
> processes is basically random, there's no way to make sure that
> processes doing work on behalf of a fuse filesystem (B) are frozen
> after processes accessing the fuse filesystem (A).

Sorry. You're right - I was confusing things in what I said, but I do
have a (unconfused) solution:

The answer is to freeze the fuse filesystems first, stopping new
requests (freezing the processes making them) before they are passed on
to userspace and allowing existing requests to complete or freeze. Once
that is done, the userspace fuse processes will be idle, at least as far
as fuse activity is concerned. After fuse activity is stopped, userspace
can be frozen without worrying about what processes are fuse and what
aren't. This is what my patch implements so far.

To deal with requests that are already in progress, I'd suggest three
possibilities, in the order I think they should be preferred.

1) Use wait_event_freezeable[_timeout] in fuse code. Probably preferable
to #2, but I thought of it later :)

2) Use freezer_do_not_count as part of FUSE_MIGHT_FREEZE (resetting
before exiting the callers, of course). If the request doesn't complete
during the freezing period, it must be because the userspace thread was
already frozen. If the request does complete, we're counted again during
the normal freezing of userspace that follows the freezing of
filesystems.

3) Adding a means to check whether processes being frozen are fuse
requests. The code could then wait for fc->num_waiting - (say)
fc->num_frozen == 0.

Regards,

Nigel
