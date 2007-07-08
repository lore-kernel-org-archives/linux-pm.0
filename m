From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 8 Jul 2007 20:08:56 +0200
Message-ID: <200707082008.57879.rjw__41061.4777043977$1183917831$gmane$org@sisk.pl>
References: <200707050858.03638.oliver@neukum.org>
	<20070708123748.GB3866@ucw.cz>
	<E1I7Xfc-0008PO-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I7Xfc-0008PO-00@dorka.pomaz.szeredi.hu>
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

On Sunday, 8 July 2007 16:23, Miklos Szeredi wrote:
> > > > > > We can just wait for all fuse requests to be serviced before
> > > > > > proceeding further with freeze, right?
> > > > > 
> > > > > Right.  Nice way to slow down or stop the suspend with an unprivileged
> > > > > process.  Avoiding that sort of DoS is one of the design goals of
> > > > > fuse.
> > > > 
> > > > So you want me to handle _malicious_ filesystems now?
> > > 
> > > What I'd like, is a suspend, that works reliably, regardless of the
> > > state of any userspace filesystem, network servers and such.
> > 
> > Well, fix userspace filesystems and maybe NFS. If they react to
> > sigstop in timely manner, they will work with suspend properly, too.
> 
> Which is pretty much impossible, given the unix filesystem API.  To be
> able to react to sigstop, the operations in question need to be
> restartable.  Which they are not, so they can't react to sigstop.  End
> of story.

Or not.  That depends on your willingness to cooperate, I'd say. :-)

> > > > That should be easy... :-). You already have nasty deadlocks in FUSE,
> > > > and you solve them by "root can echo 1 > abort"... so allow me the
> > > > same possibility.
> > > > 
> > > > We can tell fused we are freezing, and if all the requests are not
> > > > serviced within, say, 30 seconds, we call the filesystem malicious and
> > > > do echo 1 > abort.
> > > 
> > > Arbitrary time limits, nice.  Not.
> > > 
> > > This freezer is like an old house that's close to collapsing, and you
> > 
> > Nice way to have useful discussion. Not.
> 
> Sorry, didn't mean to offend you.
> 
> > Look, Linux was not designed with malicious filesystems in mind. In
> > particular, suspend was not designed with malicious filesystems in
> > mind, and VFS was not designed with malicious filesystems in mind.
> > That's why you have the nastiness with deadlocks... which you are
> > unable/unwilling to solve because you'd have to redesign VFS and meet
> > Al Viro.
> 
> No, I don't think we need to redesign the VFS, and also I think the
> malicious filesystem thing has been adequately taken care of in fuse.
> 
> You may not like the fact that one process can cause another to go
> into uninterruptible sleep, but in fact there's nothing wrong with
> that.

Well, this introduces interdependencies between processes that do not exist
otherwise.  Even if that isn't wrong per se, it's something that needs
consideration in any case.

IMO, FUSE breaks one of the assumptions that the freezer is based on and
saying that the freezer is broken because of that is unfair.

> The effects are localized to the mount owner, it won't cause 
> any system-wide ill, it's in fact no worse than a malicious process
> doing ptrace().
> 
> And as explained above it's unavoidable due to the well established
> userspace API.  The _point_ of fuse is to let this API be used by
> unmodified programs and the filesystem be provided by a userspace
> process.  After showing me the right way to do this with Podfuk, this
> should not come as a surprise to you.
> 
> So the fact that the freezer can't handle this is unfortunate, but
> it's just a symptom of the brokenness of it, not something that fuse
> introduced.  Not being able to suspend with NFS (or other network
> filesystems) when the network is lost shows that this is a deeper
> problem.

Well, the system that cannot access its filesystems is not in a consistent
state, so it generally is not reasonable to suspend or hibernate it.

In fact, NFS and similar filesystems should always be unmounted before the
suspend/hibernation to avoid problems that may arise after the resume, if
they become unavailable at that time.

> And for some reason you seem not to accept that.  You think that the
> problem is with fuse, NFS, CIFS, whatever, and not the freezer, when
> in fact it's quite clear, that neither of the above should have
> anything to do with power management.

IMHO, it's not _that_ clear.

> Even if it was possible to fix them, it would still be just fixing the
> symptoms. 

I don't think we need to fix the network filesystems.

If there's a mounted filesystem and we have at least one process waiting for
it to become available in the D state (ie. uninterruptible), then the system is
not in a consistent state and should not be suspended.

> > Now.. freezer already includes timeout; if some part of kernel knows
> > nothing about suspend or had crashed, it will abort after some time,
> > telling you which part to blame. Another timeout for detecting
> > malicious userspace filesystems will not hurt much in this old house.
> > (Maybe you don't want to auto abort them, just tell user what happened.
> > 
> > We are stuck with refrigerator for now, and at least for hibernation,
> > I don't see any feasible alternative.
> 
> Even for hibernation, I don't see, why we would need all processes
> being effectively in a stopped state.
> 
> As stated otherwise in the thread, suspend2 in fact allowed processes
> to be in uninterruptible sleep instead, without negative side effects.

And yet, Nigel thinks that the freezer is necessary for the hibernation.
Strange, no?

> The current freezer does too much for suspend and for hibernate too.

Yes, it does.  It's quilte similar to the BKL in that.  Still, for now, there's
no infrastructure for a more fine grained approach and instead of working
on introducing one, we're losing time in this thread.

> > > Malicious programs are not something specific to fuse.  A lot of the
> > > multiuser/multitasking OS design is about isolating things, so such a
> > > program is limited in the damage it can do.
> > 
> > I'm talking malicious _filesystems_ here, and yes, fuse is first of
> > this kind. We want to handle unresponding NFS, but I believe handling
> > malicious NFS server nicely is slightly out of scope.
> 
> It doesn't have to be malicious, it's enough if the server crashes, or
> the network connection is lost.
> 
> Do we want to maintain the status quo, just because we can live with
> it?

Say you're standing on a cliff and you have three choices:
(1) stay where you are (well, this is not attractive in the long run)
(2) jump down
(3) look for a path to go down slowly?

Which one will you choose?

> > > > Not nice, but we don't know any better for now. "Just fix all the
> > > > drivers" basically means "just fix 90% of kernel".
> > > 
> > > And how much of that 90% currently has any power management?
> > 
> > Anything that's used in today's notebooks, I'd say...
> 
> Which is what, 10% of all the drivers?  Then it really not as bad as
> you try to make it sound.  And with the late suspend call (whatever it
> does) that can take care of most of those, it really becomes just a
> few drivers and subsystems to fix.

Are they fixed _now_?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
