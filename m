From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sat, 14 Feb 2009 20:44:58 +0000
Message-ID: <20090214204456.GA12950@srcf.ucam.org>
References: <20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
	<20090214000520.GA5764@srcf.ucam.org>
	<d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
	<20090214010632.GA6618@srcf.ucam.org>
	<d6200be20902131733u577e918bu7ac0ee7a90a5b471@mail.gmail.com>
	<20090214014920.GA7504@srcf.ucam.org>
	<d6200be20902132151y64421010h847223839f8068db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902132151y64421010h847223839f8068db@mail.gmail.com>
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

On Fri, Feb 13, 2009 at 09:51:22PM -0800, Arve Hj=F8nnev=E5g wrote:
> On Fri, Feb 13, 2009 at 5:49 PM, Matthew Garrett <mjg59@srcf.ucam.org> wr=
ote:
> > Like I suggested before, just multiplex them through a single daemon in
> > userspace. That lets you tie your policy into your platform specifics.
> > You get to do things like keep the lock until whatever process restarts
> > dead system components indicates that your input process is running
> > again, for instance.
> =

> OK, so you want a single daemon in userspace (init?) to handle process
> restarting and wakelocks.

That would be one way of doing it, but it would also be fine to have =

some sort of IPC between multiple daemons.

> > The retry doesn't have to be immediate. Yes, this is something of a
> > hypocritical argument given everything else I've had to say about
> > timeouts, but working out why a driver's preventing a suspend is
> > probably a Hard Problem. I don't think this single case is enough to add
> > it to the entire API.
> =

> It is not a single case. Having wakelocks with timeout support makes
> it trivial to work around the problem.

You're not describing these cases. So far we've got "We need timeouts =

because we haven't added locking everywhere that it's needed in the =

kernel" and "We need timeouts because we want to poll in the case of a =

failed suspend". I don't think these are convincing reasons - the first =

should be fixed before merging the code and the second is a hack to =

begin with. Getting -EBUSY and then setting a wakelock with a timeout to =

trigger a resuspend would be more cleanly implemented by scheduling a =

timeout to re-trigger the attempt.

> > Remember that for things like IDE we probably need to have locks in the
> > fast path. An atomic_inc is a lot cheaper than a spinlock protected
> > list_add.
> =

> The slow path for spinlocks and atomic operations are about the same.
> On an smp arm v6 we have:

On x86 an uncontended spin_lock()/spin_unlock() cycle appears to be an =

order of magnitude slower than an atomic_inc. How much this matters =

probably depends on how frequently you think these locks will be taken =

and what the probability of them being contended is.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
