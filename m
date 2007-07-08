From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 08 Jul 2007 21:50:12 +0200
Message-ID: <E1I7clo-0000JY-00@dorka.pomaz.szeredi.hu>
References: <200707050858.03638.oliver@neukum.org>
	<20070708123748.GB3866@ucw.cz>
	<E1I7Xfc-0008PO-00@dorka.pomaz.szeredi.hu>
	<200707082008.57879.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707082008.57879.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > Well, fix userspace filesystems and maybe NFS. If they react to
> > > sigstop in timely manner, they will work with suspend properly, too.
> > 
> > Which is pretty much impossible, given the unix filesystem API.  To be
> > able to react to sigstop, the operations in question need to be
> > restartable.  Which they are not, so they can't react to sigstop.  End
> > of story.
> 
> Or not.  That depends on your willingness to cooperate, I'd say. :-)

Do you actually understand what I'm talking about?  Because it sure
doesn't depend on my cooperation.

Maybe I'm stupid, and I'm missing something obvious.  In that case
please explain how you propose to make filesystem operations, like
rename() restartable.

> > You may not like the fact that one process can cause another to go
> > into uninterruptible sleep, but in fact there's nothing wrong with
> > that.
> 
> Well, this introduces interdependencies between processes that do not exist
> otherwise.  Even if that isn't wrong per se, it's something that needs
> consideration in any case.
> 
> IMO, FUSE breaks one of the assumptions that the freezer is based on and
> saying that the freezer is broken because of that is unfair.

The freezer is not broken because of that, it's broken anyway.  What
we are seeing is a _symptom_ of it being broken.

And by broken, I don't mean it's buggy or that it was badly designed.
I just mean, that it's simply not what suspend should depend on, to
protect drivers.

> > So the fact that the freezer can't handle this is unfortunate, but
> > it's just a symptom of the brokenness of it, not something that fuse
> > introduced.  Not being able to suspend with NFS (or other network
> > filesystems) when the network is lost shows that this is a deeper
> > problem.
> 
> Well, the system that cannot access its filesystems is not in a consistent
> state, so it generally is not reasonable to suspend or hibernate it.

Saying the system must be in a "consistent" state, and defining
consistent as "every process is stopped", is just an arbitrary
limitation that fits what the freezer does now.  Yes the _hardware_
state must be consistent, but that has nothing to do with either fuse
or NFS.  Can't you see that?

> > As stated otherwise in the thread, suspend2 in fact allowed processes
> > to be in uninterruptible sleep instead, without negative side effects.
> 
> And yet, Nigel thinks that the freezer is necessary for the hibernation.
> Strange, no?

I'm totally ignorant about why the freezer is necessary for hibernate.
Please explain.

Yes, we need to make sure, that nothing is scheduled during (and
possibly after) taking the snapshot.  But AFAICS that could be
achieved by unplugging all but one CPU.

Miklos
