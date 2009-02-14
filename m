From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 21:51:22 -0800
Message-ID: <d6200be20902132151y64421010h847223839f8068db@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
	<20090214000520.GA5764@srcf.ucam.org>
	<d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
	<20090214010632.GA6618@srcf.ucam.org>
	<d6200be20902131733u577e918bu7ac0ee7a90a5b471@mail.gmail.com>
	<20090214014920.GA7504@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090214014920.GA7504@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 5:49 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Fri, Feb 13, 2009 at 05:33:35PM -0800, Arve Hj=F8nnev=E5g wrote:
>> On Fri, Feb 13, 2009 at 5:06 PM, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
>> > On Fri, Feb 13, 2009 at 04:50:11PM -0800, Arve Hj=F8nnev=E5g wrote:
>> >> Or when not trusting userspace. In the last user space api, I also use
>> >> a timeout when a process dies with a wakelock locked.
>> >
>> > That's policy that's easily to implement in userspace.
>>
>> How? When the process dies its wakelock is destroyed. With the old
>> sysfs interface, this was not a problem since the wakelocks were not
>> cleaned up. If we allow userspace wakelocks to be persistent, then
>> there is no limit on how many wakelocks userspace can create (which
>> was one of the objections against the sysfs interface).
>
> Like I suggested before, just multiplex them through a single daemon in
> userspace. That lets you tie your policy into your platform specifics.
> You get to do things like keep the lock until whatever process restarts
> dead system components indicates that your input process is running
> again, for instance.

OK, so you want a single daemon in userspace (init?) to handle process
restarting and wakelocks.

>> >> That is a pretty big leap. There is no wakelock api in the current
>> >> kernel. I think the absence of an api is a more plausible explanation
>> >> for it not being used than that people do not like the api.
>> >
>> > If an acceptable API gets merged then there's no reason not to quickly
>> > spread it to the sections of the kernel which would benefit.
>>
>> It is not trivial to add wakelocks to every section of the kernel that
>> may need to run.
>
> Doing things right is often harder, yes :)
>
>> > I think it would be pretty acceptable to schedule a retry for the
>> > suspend if the count is still zero at that point.
>>
>> I don't. If a driver returns -EBUSY the system will use 100% cpu until
>> either the driver stops returning -EBUSY, or someone else locks a
>> wakelock.
>
> The retry doesn't have to be immediate. Yes, this is something of a
> hypocritical argument given everything else I've had to say about
> timeouts, but working out why a driver's preventing a suspend is
> probably a Hard Problem. I don't think this single case is enough to add
> it to the entire API.

It is not a single case. Having wakelocks with timeout support makes
it trivial to work around the problem.

>
>> >> We always use the debug case. I don't think a list of device struct is
>> >> better than a list of wakelocks.
>> >
>> > You may. Others will not. There's benefit in simplifying the non-debug
>> > case.
>>
>> A counter is not significantly simpler than a list if you remove all
>> the debug and timeout support:
>> lock:
>>   list_add
>> unlock:
>>   list_del
>>   if list_empty
>>     schedule suspend
>
> Remember that for things like IDE we probably need to have locks in the
> fast path. An atomic_inc is a lot cheaper than a spinlock protected
> list_add.

The slow path for spinlocks and atomic operations are about the same.
On an smp arm v6 we have:

static inline void __raw_spin_lock(raw_spinlock_t *lock)
{
	unsigned long tmp;

	__asm__ __volatile__(
"1:	ldrex	%0, [%1]\n"
"	teq	%0, #0\n"
#ifdef CONFIG_CPU_32v6K
"	wfene\n"
#endif
"	strexeq	%0, %2, [%1]\n"
"	teqeq	%0, #0\n"
"	bne	1b"
	: "=3D&r" (tmp)
	: "r" (&lock->lock), "r" (1)
	: "cc");

	smp_mb();
}


and:

static inline int atomic_add_return(int i, atomic_t *v)
{
	unsigned long tmp;
	int result;

	__asm__ __volatile__("@ atomic_add_return\n"
"1:	ldrex	%0, [%2]\n"
"	add	%0, %0, %3\n"
"	strex	%1, %0, [%2]\n"
"	teq	%1, #0\n"
"	bne	1b"
	: "=3D&r" (result), "=3D&r" (tmp)
	: "r" (&v->counter), "Ir" (i)
	: "cc");

	return result;
}



>
>> > I think the name doesn't do a good job
>> > of indicating what's going on, and I think the timeout aspect is a
>> > misfeature.
>>
>> I understand your objection to using timeouts, but removing the use of
>> timeouts is not currently an option. If you accept that timeouts will
>> be used, supporting them in the wakelock code simplifies the drivers
>> and reduces overhead.
>
> Why is it not an option?

I think we have covered this.

-- =

Arve Hj=F8nnev=E5g
