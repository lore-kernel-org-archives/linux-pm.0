From: Salman Qazi <sqazi@google.com>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the Linux Kernel
Date: Mon, 14 Dec 2009 16:42:30 -0800
Message-ID: <4352991a0912141642o75c67d5aja8351989b1743ee6__40732.8703361147$1260893064$gmane$org@mail.gmail.com>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<876389xhuk.fsf@basil.nowhere.org> <20091214235151.GG4867@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091214235151.GG4867@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Andi Kleen <andi@firstfloor.org>, Salman Qazi <sqazi@google.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 14, 2009 at 3:51 PM,  <tytso@mit.edu> wrote:
> On Tue, Dec 15, 2009 at 12:21:07AM +0100, Andi Kleen wrote:
>> Salman Qazi <sqazi@google.com> writes:
>> >
>> > We'd like to get as much of our stuff upstream as we can. =A0Given that
>> > this is a somewhat sizable chunk of work, it would be impolite of me
>> > to just send out a bunch of patches without hearing the concerns of
>> > the community. =A0What are your thoughts on our design and what do we
>> > need to change to get this to be more acceptable to the community? =A0I
>> > also would like to know if there are any existing pieces of
>> > infrastructure that this can utilize.
>>
>> There were a lot of discussions on this a few months ago in context
>> of the ACPI 4 "power aggregator" which is a similar (perhaps
>> slightly less sophisticated) concept.
>>
>> While there was a lot of talk about teaching the scheduler about this
>> the end result was just a driver which just starts real time threads
>> and then idles in them. This is in current mainline.
>>
>> It might be a good idea to review these discussions in the archives.
>
> It should be noted that most of the heat from those discussions was
> over adding the ACPI 4 mechanism to accept requests from the hardware
> platform to add idle cycles in the case of thermal/power emergencies,
> before we had the scheduler improvements to be able to do so in the
> most efficient way possible. =A0See the description of commit 8e0af5141:
>
> =A0 ACPI 4.0 created the logical "processor aggregator device" as a
> =A0 mechinism for platforms to ask the OS to force otherwise busy
> =A0 processors to enter (power saving) idle.
>
> =A0 The intent is to lower power consumption to ride-out transient
> =A0 electrical and thermal emergencies, rather than powering off the
> =A0 server....
>
> =A0 Vaidyanathan Srinivasan has proposed scheduler enhancements to
> =A0 allow injecting idle time into the system. This driver doesn't
> =A0 depend on those enhancements, but could cut over to them when they
> =A0 are available.
>
> =A0 Peter Z. does not favor upstreaming this driver until the those
> =A0 scheduler enhancements are in place. However, we favor upstreaming
> =A0 this driver now because it is useful now, and can be enhanced over
> =A0 time.
>
> It looks to me that scheme that Salman has proposed for adding idle
> cycles is quite sophisticated, probably more than Vaidyanathan's, and
> the main difference is that Google wants the ability to be able to
> control the system's power/thermal envelope from userspace, as opposed
> to letting the hardware request in an emergency situation. =A0This makes
> sense, if you are trying to balance the power/thermal requirements
> across a large number of systems, as opposed to responding to a local
> power/thermal emergency signalled from the platform's firmware.
>

This is correct.  The source of our signal is user space software on
remote machines ("hierarchical regulators") that have information
about power usage across multiple machines at various levels of power
hierarchy.  This is ultimately delivered to a local daemon, which
communicates it to the kernel.

As we are not using this as an emergency measure, we are very
concerned about the performance implications.

> So it would seem to me that Salman's suggestions are very similar to
> what Peter requested before this commit went in (over his objections).
>
> Regards,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0- Ted
>
>
