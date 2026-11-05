Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913546;
	b=ryqn3j7xpsgPgBdNXO4zigpKzS0BOrrhxQbLoqk7uSyYjtycdU7OR5icqHs3vavN+z39
	 44FEtB6vjOKJJSiFa7ieWoAWyu1G4nldFtNlEBH+Stj3UNiL0/Et9YTNE96Blgm5R4jVA
	 bGca7cdvelM33W/xDta+dlxFaD3KthCMQhRQlvhOra3tfWnEs7jyxphpheaVNLQEM0vPE
	 SIGyx7qn2xoASYWtT04hi7I2HXD23NxTn8S9Kc6LcnREYRQVg/hU9krjqHHKgF5SY1ASn
	 JeSdKSm4xf+LqcnbVafAhjKU4/A/8ULE/V66T7fNLegoiNr9IxUNtkoHClZIMD52EyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913546;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1rj8tKO5/pFqbT+hKQWjyojZu6Y+BFNIgIDZkUjrPRE=;
	b=PgumOJerrnQWpxKwW1KYgrtiEmFHLL4pVK3H0uFYESHW8AfkpmJz5d2CWgZfihyyT5g8
	 YG6qcZoP6EpApNOn+4Lkuog3KUfDvLILVq6Tf/sQ2tQj2ofuHRNbBuol0XTWO1A2SUUaz
	 +X6w9kOUfwpp/Xn6I2iiU4wCS640K1bZ1104FwheqC3k7HUMeul53HZqdpkYldSgjIU6x
	 xxNVX8zlFexH1JNFEh+OANvggmxq1x6Aa2AUkKkEdE0z8RDDbwuxmg+tSpl1d18OhevTt
	 2U2CpFGKgobnyE66BJJCbLjCZ1j/WKsLU3ccCGlNG1VrRKBtRUHw0RvgnWSrEUYggkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQAfmjej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37C606A332
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQAfmjej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1542D1F008A2
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913546;
	bh=1rj8tKO5/pFqbT+hKQWjyojZu6Y+BFNIgIDZkUjrPRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eQAfmjejgdnCzPDmmvL1g4LJ0FSdCE6YGj3poL/nTRncVJqtrGf9Q9sdCQFzE11Pu
	 /lEVBQMzOx/43xG2n7rf9MHAQ3mwFDHSy0i7OzmcV7yeEzftKgxESCHD+jPPs2KOLv
	 QX7XNYXqgT2MHjP2nM0zoLzX7fiNPfIZ7WeblwnPUWes7KGOOC5Nc3ZXiXLD+FSSBP
	 l637S64oF3PGjMII3+031JqODU00rZZHTUKrMmk249le5undNVv4sk5TV7uBuH6XKA
	 ANqHplOYmuq1Iy5KOQqh/ce3kYJyxQBBk+qE5TdT6nUWJWREJbcFfWdN5rVgtx54dI
	 wDme9hKUsZMlA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be4d648aacso2042962e87.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 13:19:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxJ+dfVWYmcypuoK0lBjQIof1pp9UknkS6xS7ynShgOMK3td5NVypQUR3M4ASZ6qi7SWVQ/cPUmmA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+170CwJ5bYaVvG1GnI+HYSJHU2ggBVEuyRS7atnE+5in8oflku
	O3NA6VUDoUfxhvZvPVmCMQSdGUc8hA5HEq6PqQh9x7PUAY+kVoBywna4TxbmQGPy1MRydeylXRm
	uWJk8ofKGm0i/wGDyrkwhN7BPOTNBYMk=
X-Received: by 2002:a05:6512:3d15:b0:5bc:f29b:1a5c with SMTP id
 2adb3069b0e04-5c003ac490dmr84970e87.23.1793913544353; Thu, 05 Nov 2026
 13:19:04 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com> <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
In-Reply-To: <auzlLwlleGLPsLcw@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 22:18:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
X-Gm-Features: AclHuK_Rw1SqQ-ayyKUPK1R6gu5PeotgZxuqEl-8c-_ZkMhL2cIhEUfo-I4VHDo
Message-ID: <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent to dependency
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:21=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Hi Rafael,
>
> On Thu, Nov 05, 2026 at 12:59:24PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Nov 4, 2026 at 8:31=E2=80=AFPM Brian Norris <briannorris@chromi=
um.org> wrote:
> > >
> > > On Wed, Nov 04, 2026 at 02:34:22PM +0100, Rafael J. Wysocki (Intel) w=
rote:
> > > > I should have responded to the v1 of this, but didn't manage to get=
 to
> > > > it.  Sorry about that.
> > >
> > > Hehe, well that's what v2 is for :)
> > >
> > > Thanks for looking.
> > >
> > > > On Tue, Nov 3, 2026 at 11:23=E2=80=AFPM Brian Norris <briannorris@c=
hromium.org> wrote:
> > > > >
> > > > > When a child device suspends, it does not update the last_busy ti=
mestamp
> > > > > for its parent. If that parent configured autosuspend and didn't
> > > > > otherwise maintain its last_busy timestamp, it may now be immedia=
tely
> > > > > eligible to suspend. This is probably not expected -- the parent =
should
> > > > > wait for its autosuspend delay before suspending.
> > > >
> > > > Let's first talk about what autosuspend is for: My understanding is
> > > > that it is there to avoid incurring the runtime PM suspend and resu=
me
> > > > latency (and cost in terms of energy) in the cases when the device =
is
> > > > known or at least is expected to be needed in the near future.  IOW=
,
> > > > we want to defer the runtime suspend of the device because if it
> > > > suspended, it would be resumed shortly thereafter.
> > > >
> > > > I'm not sure if that is always the case when a dependent device
> > > > suspends and its reference to the parent/supplier is dropped.
> > >
> > > To be clear: dropping a reference is not the point at which we extend
> > > the timer -- it's simply the point at which we propagate the last_bus=
y
> > > timestamp.
> > >
> > > The naive algorithm is:
> > > Every time a device updates its last_busy, sync that timestamp to all
> > > its dependencies.
> > >
> > > My proposal modifies that naive algorithm so that it avoids additiona=
l
> > > graph walks -- it defers that "sync" step until later. (Now that I'm
> > > spelling this out, I feel like I should have included this in the com=
mit
> > > message...)
> >
> > OK, thanks for explaining!
> >
> > You seem to be arguing that the current behavior is counter-intuitive
> > because people would generally expect the parent's (or supplier's)
> > last_busy to be automatically advanced to the last "busy" time of its
> > last active child (or consumer).
>
> More or less. Or, I don't see why "child was recently busy and may be
> busy again soon" should not translate to "everything the child uses
> might be needed again soon".
>
> > That is a bit far-fetched IMV because the child's last "busy" time
> > need not be the same as the parent's last "busy" time, at least in
> > principle (of course, that is debatable, but that debate can be had
> > later).
>
> I don't get this -- I'm very much asking for that debate right now,
> because so far, I disagree :)
>
> > Still, the underlying observation seems to be that if the child
> > suspends and then resumes relatively shortly, it may not make sense to
> > suspend and resume the parent in the meantime, which is fair enough.
> > Of course, advancing the parent's last_busy will only help here if its
> > autosuspend delay is long enough though.
>
> Right. But that's the whole point of this argument -- if all autosuspend
> delays were the same, this wouldn't really matter. But the presumption
> is that the parent wants delay because it's more costly -- it will be
> imposing extra wakeup cost for its children if it's not accounted
> properly.
>
> > So you can argue that if the parent's autosuspend delay is long
> > enough, then it should prevent the parent from suspending across
> > relatively short periods of child suspension.  Again, this is fair
> > enough, so why does it not happen at times?
> >
> > It certainly does happen when the parent actually has to resume
> > because rpm_resume() calls pm_runtime_mark_last_busy() for it then and
> > (given a sufficiently long autosuspend delay) it will stay active if
> > the child resumes a short enough time after suspending.  However, when
> > the child resumes, the parent is still active, so rpm_resume()
> > triggered by the child does not advance its last_busy timestamp, so at
> > one point in the future it will suspend when the child suspends.
> >
> > This arguably is inconsistent, so my approach to addressing the
> > problem at hand would be the attached patch (sorry for the attachment,
> > but GMail is generally not good at handling appended patches).  If I'm
> > not mistaken, it should be sufficient to address the particular issue
> > that triggered commit c537d3457542.
>
> It's only sufficient if the child is not active for "too long". Suppose
> the child stays active for 2s and then suspends briefly; your solution
> does not work.

It doesn't work in the sense that it doesn't do what you want.  But fair en=
ough.

> In commit c537d3457542, I imagine the 0.2s polling example is just an
> example;

I'm not sure about that, but OK, say it's just an example.

> what if that period was 0.1s, with some natural variance up or
> down? Then I could easily see how the child remains active for longer
> than 2s, and then occasionally is inactive for longer than 0.1s,
> allowing both the child and parent to autosuspend.
>
> Or in concrete terms: see the appended test diff, which attempts to
> emulate:
>
>  - 200 cycles of child get/put
>  - delay in between each put -> get cycle
>  - delay of approximately 100ms, with a configurable +/- variation
>  - apply the shorter variation (e.g., 90ms) most of the time, with a
>    longer variation approximately every 2s
>
> So for example, that looks something like:
>
>  cycle 0 to 22:   delay 90ms
>  cycle 23:        delay 110ms
>  cycle 24 to 46:  delay 90ms
>  ...
>
> With your patch:
>
>    0ms variation =3D=3D PASS (child suspends 200 times, parent suspends 0=
 times)
>   10ms variation =3D=3D FAIL (child suspends 21 times, parent suspends 4 =
times)
>   20ms variation =3D=3D FAIL (child suspends 7 times, parent suspends 7 t=
imes)
>   30ms variation =3D=3D FAIL (child suspends 6 times, parent suspends 6 t=
imes)
>   40ms variation =3D=3D FAIL (child suspends 5 times, parent suspends 5 t=
imes)
>   50ms variation =3D=3D FAIL (child suspends 4 times, parent suspends 4 t=
imes)
>   60ms variation =3D=3D FAIL (child suspends 3 times, parent suspends 3 t=
imes)
>   70ms variation =3D=3D FAIL (child suspends 2 times, parent suspends 2 t=
imes)
>   80ms variation =3D=3D FAIL (child suspends 1 time, parent suspends 1 ti=
me)
>   90ms variation =3D=3D PASS (test didn't run long enough to fail)
>
> With my patch, all cases pass. (The child suspends in the same pattern,
> but the parent does not suspend in between.)
>
> For comparison, with neither patch:
>
>    0ms variation =3D=3D FAIL (child suspends 200 times, parent suspends 1=
0 times)
>   10ms variation =3D=3D FAIL (child suspends 14 times, parent suspends 8 =
times)
>   20ms variation =3D=3D FAIL (child suspends 7 times, parent suspends 7 t=
imes)
>   30ms variation =3D=3D FAIL (child suspends 6 times, parent suspends 6 t=
imes)
>   40ms variation =3D=3D FAIL (child suspends 5 times, parent suspends 5 t=
imes)
>   50ms variation =3D=3D FAIL (child suspends 4 times, parent suspends 4 t=
imes)
>   60ms variation =3D=3D FAIL (child suspends 3 times, parent suspends 3 t=
imes)
>   70ms variation =3D=3D FAIL (child suspends 2 times, parent suspends 2 t=
imes)
>   80ms variation =3D=3D FAIL (child suspends 1 time, parent suspends 1 ti=
me)
>   90ms variation =3D=3D PASS (test didn't run long enough to fail)
>
> So, your patch makes an improvement, but it doesn't handle this kind of
> variation very well.

And it is not designed to do so.

Of course, it will not prevent the parent from suspending if the child
does not attempt to resume it for a time longer than its autosuspend
delay.  That's by design and you didn't have to take the time to
demonstrate it.

The question is how often those kinds of patterns occur in practice.
Or IOW, whether or not they occur often enough to justify adding
complexity related specifically to addressing them.

> > Note that I'm not worried about the potential raciness of this new
> > last_busy update with other possible concurrent updates of last_busy
> > because they all use approximations of the current time and if they
> > are close enough to each other, it should not matter who wins the
> > race.
>
> Ack, that's one advantage in your style of solution, because you're only
> handling timestamps "in the moment."
>
> > > With that said:
> > >
> > > > The core calls pm_runtime_mark_last_busy() for resuming devices und=
er
> > > > the assumption that they are resumed for a reason and so it is like=
ly
> > > > that they will be needed in near future, but I'm not sure if that
> > > > assumption can be extended to a child suspend case.
> > >
> > > But that's not what I'm doing: I'm not calling mark_last_busy() -- I'=
m
> > > just making mark_last_busy() transitive to all dependencies. So any t=
ime
> > > we *already* say the child is busy, I also extend that to the parent =
--
> > > I'm not generating any new timestamps; I only reuse the timestamps we
> > > already selected.
> > >
> > > My view on the logic (using your terms above): when a child calls
> > > mark_last_busy(), it suggests that child might be needed in the near
> > > future. Whenever a child device is needed, so is its parent (barring
> > > ignore_children). Thus, mark_last_busy() should also refresh the
> > > parent's busy timestamp.
> >
> > Of course, it can be argued this way though there are
> > counter-arguments (probably not worth discussing in detail at this
> > point) and there is the question how much of a difference this would
> > make after addressing the rpm_resume() inconsistency mentioned above
> > (which IMV needs to be address regardless because it is not limited to
> > the parent-child or supplier-consumer situations).
>
> I would love to hear your counterarguments.

OK, I'll say more about that tomorrow (it's past 10 PM here, time to
go away from the keyboard).

> I don't believe your solution solves the problem,

That depends on what problem in particular you mean.

It addresses an inconsistency in rpm_resume() and as I said above,
this needs to be done anyway because it is not only related to the
cases when children or consumers are involved.  There are other cases
in which rpm_resume() gets called for an active device and the lack of
last_busy update causes the device to suspend earlier than expected.

> and my solution does while also handling
> the inconsistency you mention.

I'm not sure about that.

For example, say a device has an autosuspend delay of 2 s.  Say it is
initially suspended and user space writes "on" to its "power/control",
so the device resumes.  Now, 1 s later, user space writes "auto" to
the device's "power/control" and the autosuspend delay is respected,
so the device doesn't suspend.  Next, 1.5 s after the first resume,
user space writes "on" to the device's "power/control" and the device
does not resume because it is active (its last_busy is not updated).
Finally, user space writes "auto" to the device's "power/control", say
1 s later, and the device suspends even though it can be expected to
stay active for at least 1 s more.

How is that going to be addressed by propagating last_busy from
children/consumers to parents/suppliers?

Note that I'm not dismissing your proposal, I'm just having doubts
about the need to do this kind of thing in the core code.
