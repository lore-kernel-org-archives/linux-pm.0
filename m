From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Mon, 27 Oct 2008 22:09:15 +0100
Message-ID: <E1KuZKt-0003jl-2N__24057.8489531346$1225141919$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
	<200810271237.40049.rjw@sisk.pl>
	<1225107607.26724.9.camel@nigel-laptop>
	<E1KuRN4-0002gS-Hq@pomaz-ex.szeredi.hu>
	<1225141168.26724.23.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225141168.26724.23.camel@nigel-laptop> (message from Nigel
	Cunningham on Tue, 28 Oct 2008 07:59:28 +1100)
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

On Tue, 28 Oct 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2008-10-27 at 13:38 +0100, Miklos Szeredi wrote:
> > On Mon, 27 Oct 2008, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Mon, 2008-10-27 at 12:37 +0100, Rafael J. Wysocki wrote:
> > > > Well, I guess it's better if you post the entire thing so that we can see
> > > > what the role of the $subject patch is in it, even if this patch finally gets
> > > > merged separately.
> > > 
> > > Ah.. that makes me see how vfs_check_frozen was getting triggered...
> > > (fs/namei.c, below).
> > 
> > Nigel, thanks for the patch, it makes thinks a lot clearer.
> > 
> > >From a quick look through the patch it seems to solve a bunch of cases
> > where new fuse requests during the freezing could cause problems.  But
> > it doesn't do anything with requests that are already under way when
> > the freezing starts, which would still result in all the same
> > problems.
> > 
> > Take this scenario:
> > 
> >  1) process A does rename("/mnt/fuse/a", "/mnt/fuse/b")
> >  2) request goes to process B serving the fuse filesystem
> >  3) filesystems are frozen, no new fuse requests
> >  4) processes are frozen, let's say B first, then A
> >  5) freezing A will fail, since it's still waiting for the request to finish
> 
> I'll have a look at the code again. I deliberately didn't stop existing
> requests, but perhaps that's the wrong behaviour.
> 
> In the above scenario, process B won't see process A's new request until
> post-resume if the filesystem is already frozen, so steps 4 & 5 don't
> happen.

No, I mean the filesystem is only frozen at 3 not before, so B is
already processing the request by the time the filesystem gets frozen.

> Process B will also always be frozen before process A if process
> A is userspace (most likely in the above scenario) or was mounted after
> process B. (I've had this patch distributed as is for almost a year,
> with no problems at all, so I believe I'm right here).

Both A and B are userspace processes.  The order of freezing userspace
processes is basically random, there's no way to make sure that
processes doing work on behalf of a fuse filesystem (B) are frozen
after processes accessing the fuse filesystem (A).

Miklos
