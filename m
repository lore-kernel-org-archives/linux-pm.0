From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 19:29:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<1150420919.7725.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150420919.7725.75.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> But how can you save a sate and use it for resume if the device can
> still operate on further requests ? Your state won't be consistent
> anymore... the state your resume function will get will _not_ match the
> last known hardware state. Pretty annoying.

Not annoying at all, and there is absolutely no disconnect.

> Also that means that for things like STD and kexec, you still need a
> second step "suspend" phase to actually stop DMAs which involve stopping
> processing.

That's the _real_ suspend. The last thing you do. The thing you do _after_ =

you've saved the snapshot.

> Network drivers rarely need to save anything :) Most of their state is
> in the netdev structure (MAC address, multicast filters, etc...) thus
> it's in many case fairly easy to just restore the whole driver from that
> without needing a specific state saving phase.

Ok, take a deep breath, and think that thought through.

It turns out that _no_ drivers really need to save anything at all, except =

the fundamental state that we cannot regenerate directly.

Think about it.

All the rest of the state is stuff that the driver knows to do, and it's =

about _driver_ state, not hardware state.

So let's just look at one really bad situation, which is USB. First off, =

are we all in argeement that USB is important, and not likely to go away? =

Are we also in agreement that it's entirely possible that the main system =

disk is behind USB, and that it might be a good idea to support suspend to =

disk off such a thing?

So think about that. You're saying that is "impossible" to do, as is =

apparently Pavel, because USB - in order to work - needs to have all its =

DMA lists active.

I'm saying it's not impossible at all, and in fact, if you just shift your =

perceptions a bit, it turns out to fall right out of the whole "save the =

state first, but don't shut down" approach.

I'll tell you the _simple_ solution first, just because the simple =

solution actually explains what it is all about. It's not the perfect =

solution, but once you actually understand the simple solution, it's also =

very obvious how to get to better solutions - they're not fundamentally =

different.

So the problem is, that we want to save the system image, but in order to =

save it, USB has to be active, which means that the image we save is =

"corrupt". The solution is to _let_ it be corrupt, and revel in the fact =

that we don't need it to be some magic "snapshot in time".

What we do is:

 - we realize that all the USB command lists in memory are all totally =

   uninteresting, BECAUSE WE GENERATED THEM OURSELVES. We say: "we will =

   throw away all the command list on resume, instead of trying to =

   continue using them".

   There's two things to notice: there's no _information_ in the command =

   lists. We cannot have a USB event "active" over the reboot anyway, =

   we'll need to re-connect all devices regardless, so any old command =

   lists by definition don't actually _matter_.

   The other thing to notice is that none of this is "hardware state". So =

   when we do the "save_state()" thing, that does _not_ imply saving off =

   the USB command lists. Not at all. It means saving off things like the =

   USB controller setup, things like where in PCI space its registers got =

   mapped when we booted and did the original device discovery.

   We may choose to do that by just saving-and-restoring the actual PCI =

   config space (which is easy, and you can use a generic helper for that, =

   so that's probably the way to go), or we could just decide that we =

   don't want to do even that, because we can just re-write the =

   information using the device resources, which we already save off (and =

   which, unlike things like the URB lists themselves, are _not_ =

   changeable, so there's no problem with saving them off)

See? If you take this approach, you do actually end up saving off memory =

that may be changing as you save it (imagine, for example, writing to disk =

the very memory that contains the URB that does the writing itself, and =

that will change from "ready" to "completed" after the write), AND IT =

DOESN'T MATTER. Because, on resume, you don't actually use it, you =

re-create it all.

Btw, most devices don't even _have_ this issue. Most devices don't _have_ =

memory that ends up changing, or if they have, they're not actually going =

to be part of the write-out, so when they resume, they don't need to worry =

about their memory being part of what got changed/freed.

Basically, devices that don't hold on to pointers to data areas in memory =

will never see this issue. USB, in many ways, is the worst possible case =

(a lot of other devices will obviously similarly do command structures in =

memory, but a lot of _those_ do it purely to statically allocated memory, =

so they can just clear the thing on resume, and start again).

See? Suddenly, by accepting the fact that you don't have to get an "atomic =

snapshot", you are freed to do things much more easily.

Now, what are the real problems? The thing I glossed over in the above =

explanation is that the simple approach will leak memory. Once we're in =

the "write memory" phase, what we can _not_ allow is to save off a memory =

management description that isn't valid. So while we're in the writeout, =

we cannot mark the temporary memory that we free after writeout as =

"freed", because that could cause some _important_ memory data to be =

incoherent. Similarly, we have to be very careful to allocate any new =

memory (that will be thrown away) without corrupting the page/kmalloc =

lists that we may be in the process of writing.

In other words, it's a MM problem. We have to snapshot the MM state at =

some point, and that's going to be the state we resume with, even if some =

memory got freed, or some device temporary memory got allocated. We don't =

care about the allocated, because when we resume, we're supposed to throw =

it away _anyway_, but the point is, we have to throw it away whether we =

strictly needed to or not.

Avoiding that _memory_leak_ is much harder than the device resume itself, =

I believe. It needs some clever work, marking the memory that can be =

safely re-used by having it in a special memory pool or something.. So =

there are solutions, but they are definitely harder than not doing it.

		Linus
