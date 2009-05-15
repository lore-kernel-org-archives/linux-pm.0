From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Fri, 15 May 2009 19:01:24 +0900
Message-ID: <aec7e5c30905150301l2d885b85u6fb7708aa335d44b@mail.gmail.com>
References: <aec7e5c30905132129v2abb7c72r20fa8b748d42deb6@mail.gmail.com>
	<Pine.LNX.4.44L0.0905141114590.3004-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905141114590.3004-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 15, 2009 at 12:28 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Thu, 14 May 2009, Magnus Damm wrote:
>
>> So let's look at it from a different angle then. Today there are many
>> SoCs on the market from multiple vendors, and they all need to be
>> power managed somehow. Upstream linux is not very good at it,
>
> The reason is that there aren't enough runtime power management
> implementations for anybody to know how a good design should work.
> What parts belong in the core, what parts belong in the driver, what
> parts belong in arch-specific code, and so on? =A0There's no consensus
> and so there's no upstream development.

I guess that itself may be a result of the good old embedded snapshot
development strategy... Fortunately many embedded developers know
better today.

>> =A0some
>> vendors have many out-of-tree patches for these things. For SuperH we
>> have no power management code out-of-tree so _now_ we have a good
>> chance of implementing something upstream that multiple architectures
>> can make use of.
>
> Maybe. =A0If you're really clever about it...

I'm pretty confident that we can come up with something.

>> Paul Walmsley, Kevin Hilman and I discussed this during last Embedded
>> Linux Conference last month. From architecture perspective both Arm
>> and SuperH need to be able enter deep sleep states. For this to happen
>> we need the ability to save and restore device context during run
>> time.
>>
>> Do you have any recommendation for us?
>
> Device context cannot be saved and restored in a centralized manner, as
> far as I can see. =A0The requirements vary too widely among the different
> buses and device types. =A0There's no choice but to rely on individual
> drivers or bus subsystems to take care of the details.

I totally agree. I'd like to extend the platform bus and see where
that takes us.

> So while it might make sense to have a central core invoke various
> methods to tell drivers when certain power-management events need to
> happen, the actual details of these events (like the device context or
> power state) cannot be handled by the core. =A0As a corollary, you
> shouldn't try to put a bunch of new runtime-PM-related fields in the
> core data structures. =A0And you should think twice about reusing the
> fields designed for system PM, because the issues are rather
> different.

Right. I will avoid putting device or bus specific data in common data
structures. =3D)

> Even so, there are plenty of difficulties. =A0What should the various
> methods be? =A0What should the "certain power-management events" be?
> When should they occur? =A0To be truly acceptable upstream, your
> solutions will have to work on everything from a SoC to a
> supercomputer.

Yes, but we have examples like NUMA which runs on both ends of the spectrum.

> Solving these problems in the domain of USB alone was reasonably
> straightforward, because there we know exactly what the possible states
> and power transitions are. =A0Even so, it involved a good deal of code
> and it evolved over a long period of time. =A0Doing the equivalent for an
> entire system will require a tremendous development effort.

Fortunately we have data sheet, time and upstream development
experience already. I agree that going from where we are now to
perfect will take a long time. But step by step.

Thanks for your comments and help!

/ magnus
