From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sat, 14 Feb 2009 01:49:20 +0000
Message-ID: <20090214014920.GA7504@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
	<20090214000520.GA5764@srcf.ucam.org>
	<d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
	<20090214010632.GA6618@srcf.ucam.org>
	<d6200be20902131733u577e918bu7ac0ee7a90a5b471@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902131733u577e918bu7ac0ee7a90a5b471@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 05:33:35PM -0800, Arve Hj=F8nnev=E5g wrote:
> On Fri, Feb 13, 2009 at 5:06 PM, Matthew Garrett <mjg59@srcf.ucam.org> wr=
ote:
> > On Fri, Feb 13, 2009 at 04:50:11PM -0800, Arve Hj=F8nnev=E5g wrote:
> >> Or when not trusting userspace. In the last user space api, I also use
> >> a timeout when a process dies with a wakelock locked.
> >
> > That's policy that's easily to implement in userspace.
> =

> How? When the process dies its wakelock is destroyed. With the old
> sysfs interface, this was not a problem since the wakelocks were not
> cleaned up. If we allow userspace wakelocks to be persistent, then
> there is no limit on how many wakelocks userspace can create (which
> was one of the objections against the sysfs interface).

Like I suggested before, just multiplex them through a single daemon in =

userspace. That lets you tie your policy into your platform specifics. =

You get to do things like keep the lock until whatever process restarts =

dead system components indicates that your input process is running =

again, for instance.

> >> That is a pretty big leap. There is no wakelock api in the current
> >> kernel. I think the absence of an api is a more plausible explanation
> >> for it not being used than that people do not like the api.
> >
> > If an acceptable API gets merged then there's no reason not to quickly
> > spread it to the sections of the kernel which would benefit.
> =

> It is not trivial to add wakelocks to every section of the kernel that
> may need to run.

Doing things right is often harder, yes :)

> > I think it would be pretty acceptable to schedule a retry for the
> > suspend if the count is still zero at that point.
> =

> I don't. If a driver returns -EBUSY the system will use 100% cpu until
> either the driver stops returning -EBUSY, or someone else locks a
> wakelock.

The retry doesn't have to be immediate. Yes, this is something of a =

hypocritical argument given everything else I've had to say about =

timeouts, but working out why a driver's preventing a suspend is =

probably a Hard Problem. I don't think this single case is enough to add =

it to the entire API.

> >> We always use the debug case. I don't think a list of device struct is
> >> better than a list of wakelocks.
> >
> > You may. Others will not. There's benefit in simplifying the non-debug
> > case.
> =

> A counter is not significantly simpler than a list if you remove all
> the debug and timeout support:
> lock:
>   list_add
> unlock:
>   list_del
>   if list_empty
>     schedule suspend

Remember that for things like IDE we probably need to have locks in the =

fast path. An atomic_inc is a lot cheaper than a spinlock protected =

list_add.

> > I think the name doesn't do a good job
> > of indicating what's going on, and I think the timeout aspect is a
> > misfeature.
> =

> I understand your objection to using timeouts, but removing the use of
> timeouts is not currently an option. If you accept that timeouts will
> be used, supporting them in the wakelock code simplifies the drivers
> and reduces overhead.

Why is it not an option?

-- =

Matthew Garrett | mjg59@srcf.ucam.org
