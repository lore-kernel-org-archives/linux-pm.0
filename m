From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 8 Jul 2007 23:07:14 +0200
Message-ID: <200707082307.15616.rjw__12522.9474659593$1183928454$gmane$org@sisk.pl>
References: <200707050858.03638.oliver@neukum.org>
	<200707082008.57879.rjw@sisk.pl>
	<E1I7clo-0000JY-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I7clo-0000JY-00@dorka.pomaz.szeredi.hu>
Content-Disposition: inline
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 8 July 2007 21:50, Miklos Szeredi wrote:
> > > > Well, fix userspace filesystems and maybe NFS. If they react to
> > > > sigstop in timely manner, they will work with suspend properly, too.
> > > 
> > > Which is pretty much impossible, given the unix filesystem API.  To be
> > > able to react to sigstop, the operations in question need to be
> > > restartable.  Which they are not, so they can't react to sigstop.  End
> > > of story.
> > 
> > Or not.  That depends on your willingness to cooperate, I'd say. :-)
> 
> Do you actually understand what I'm talking about?  Because it sure
> doesn't depend on my cooperation.
>
> Maybe I'm stupid, and I'm missing something obvious.  In that case
> please explain how you propose to make filesystem operations, like
> rename() restartable.

I'm not proposing that, sorry.  I'm not a filesystem expert, so don't think
I can propose a working solution here, right now.  Still, maybe something
like in fork.c, line 1409-1411 might work (I know that it won't solve the
"other tasks may be waiting on VFS mutexes" issue, but at least it may
decrease the probability of freezer failure).

> > > You may not like the fact that one process can cause another to go
> > > into uninterruptible sleep, but in fact there's nothing wrong with
> > > that.
> > 
> > Well, this introduces interdependencies between processes that do not exist
> > otherwise.  Even if that isn't wrong per se, it's something that needs
> > consideration in any case.
> > 
> > IMO, FUSE breaks one of the assumptions that the freezer is based on and
> > saying that the freezer is broken because of that is unfair.
> 
> The freezer is not broken because of that, it's broken anyway.  What
> we are seeing is a _symptom_ of it being broken.
> 
> And by broken, I don't mean it's buggy or that it was badly designed.
> I just mean, that it's simply not what suspend should depend on, to
> protect drivers.

Please have a look at the documentation update at the bottom of this patch:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc7/patches/15-freezer-make-kernel-threads-nonfreezable-by-default.patch

It says what the freezer is for in the first place. :-)
 
> > > So the fact that the freezer can't handle this is unfortunate, but
> > > it's just a symptom of the brokenness of it, not something that fuse
> > > introduced.  Not being able to suspend with NFS (or other network
> > > filesystems) when the network is lost shows that this is a deeper
> > > problem.
> > 
> > Well, the system that cannot access its filesystems is not in a consistent
> > state, so it generally is not reasonable to suspend or hibernate it.
> 
> Saying the system must be in a "consistent" state, and defining
> consistent as "every process is stopped", is just an arbitrary
> limitation that fits what the freezer does now.  Yes the _hardware_
> state must be consistent, but that has nothing to do with either fuse
> or NFS.  Can't you see that?

Well, I can agree as far as FUSE is concerned.  Still, imagine that you have
an NFS share mounted, which is unavailable at the moment and one of the
tasks waits for an I/O on it to complete (it might hold some locks needed
for suspending, but say it doesn't).  Then you suspend, take the box somewhere
else and attach to a different network with a different NFS server.  Now, you
resume and you have a mess to recover from.  Yes, it _should_ be recoverable,
but refusing to suspend in such a case is not okerkill, IMHO.

> > > As stated otherwise in the thread, suspend2 in fact allowed processes
> > > to be in uninterruptible sleep instead, without negative side effects.
> > 
> > And yet, Nigel thinks that the freezer is necessary for the hibernation.
> > Strange, no?
> 
> I'm totally ignorant about why the freezer is necessary for hibernate.
> Please explain.

See above. :-)

> Yes, we need to make sure, that nothing is scheduled during (and
> possibly after) taking the snapshot.  But AFAICS that could be
> achieved by unplugging all but one CPU.

Actually, we want things to get scheduled, because we need some of them to
save the image (to make things more difficult, we don't know what will be
needed to save the image in advance ;-)).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
