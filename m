Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237888;
	b=qPHnFLVBy3uzNFqSzkxSvML8cfU2r6XxLIqthSv6F2FtugWUPm+JUuEmZ/SicT9gDSEm
	 VJ3OFmxa2vWyhEzOfHTsMo3a5bFiiIXFaarE5KSp0mE5MsoyyEqAIAWvWidxGA2uhICii
	 L7HpLdG1mZ1zAhiuf8/2KV+mDXKQk21GpUQ4YwuNTkjNTcd6NtgsD0seUGjOEzO2iKb90
	 LZOyxwTdQRPdeP2c2T2LpqdZvKpHakW/1HbUv46sieb0bt+EBn2mSmNtpRp3ZAymATmAC
	 EWdeoEzhmmXRZiBrlrQLh44rteN2xbjljPSlAo03WlfvLxsrxHsy/7CM7ZXPmpCF/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237888;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8WX0F8nMHDszbM5NjizmqwpyrFNWwfILJpVqr66lwxI=;
	b=eTa3Dq7vqceTYIDMvk0eFydi3y2U88ZIVZv3Jrk6f84Pn7yb1KDt4On0LYqhCargnN89
	 oWmPRzB9a4XDaxIf1kiVMenx/pkNhwoDC8a7vqw3Y+fbUjrkChQ8zGJ/5iVBDiF5B9RyQ
	 /GqL70XUsKgX8gcY3WqUEA5M3afHXF75FFWE7HiWFswx9oB2PDf2c+83cyWwPDLtsNMqk
	 b5poVsOnPjy+O8nv/reLIowesykDr5s62WZvKw0HVGMl3/s3SCksV+99zE+iubeHXOLue
	 ir+PP+bHQSXS97v8bn8zg48n1yJexkscPQ9W2gn4PGmjIc3w0bDhJrfQKx0aL6/3mxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WX+sG5u7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB7606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WX+sG5u7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9FA1F008BD
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237887;
	bh=8WX0F8nMHDszbM5NjizmqwpyrFNWwfILJpVqr66lwxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WX+sG5u7EcuZwen1naP7QcR0JG9gtzcmXxO66QIgi8DHcE6a+WdwYKaatDoMxcE32
	 VefY+8zsWi578yt4cUpPkANrFgJYAfwdiYMMXIyktO72MKMQCusxwkPuBJs3peG8SF
	 yFeuZNwUb+T/SqJdwuJiKZ5zRbhQdPTM06VvFJuEGEf//TYsH5GA6yimA8eWnTyDIh
	 B7iuKorqeMjl7jYRIWvXxFmGZY5lBMX0undR4gJcqVGb/coDHJJ4huRd1v7xGJgoWr
	 JuYL812qqj5sdqiwI1jG9ZgwoFROobCxvbFj0BhgRXpewTOo+c3ry2DEQeJ9+zT7oV
	 IRvQw7UtMrttg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso899664e87.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:24:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEiUu2i9UqA86VlGZKjxiF8KygteREbppdkblunhzZRMoczfHXM356A1LDYoA/YYoea/0QN3Wp7qw==@vger.kernel.org
X-Gm-Message-State: APuU4Z99BhVSE+P2C33xw8lZ6U8cb/N6zFHzpiLeibPm2+Io5GOY1XbW
	fp10TcZknPTW4dggpYu5UuUZyKr8dJuRT2jTd8COqt0WrF7dkHrRqROQ/f6He6iik07Quahr9BU
	tQkUzoG4MgzYdK4dO+7nmeILZeFYscGc=
X-Received: by 2002:a05:6512:6cb:b0:5c1:4e41:3cdf with SMTP id
 2adb3069b0e04-5c1514e0072mr709299e87.12.1794237885651; Mon, 09 Nov 2026
 07:24:45 -0800 (PST)
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
 <auzlLwlleGLPsLcw@google.com> <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
In-Reply-To: <au0oKFb9CmNzc6Cg@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 16:24:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
X-Gm-Features: AclHuK931oANkV8p6-cRViUQLiT63hdK6qIBRvMQXju8Za-NQWods2ppuhoMaf0
Message-ID: <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
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

On Fri, Nov 6, 2026 at 2:06=E2=80=AFAM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> On Thu, Nov 05, 2026 at 10:18:52PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > Of course, it will not prevent the parent from suspending if the child
> > does not attempt to resume it for a time longer than its autosuspend
> > delay.  That's by design and you didn't have to take the time to
> > demonstrate it.
>
> To be clear, I wasn't just trying to demonstrate for fun or because it
> wasn't clear. I think there's value in putting concrete reproducible
> test cases out there. (KUnit is an easier common ground than some
> particular piece of obscure hardware.)
>
> > The question is how often those kinds of patterns occur in practice.
> > Or IOW, whether or not they occur often enough to justify adding
> > complexity related specifically to addressing them.
>
> Well, I tried to keep very close to the spirit of the actual real
> reports in question. So when commit c537d3457542 says, "As an example
> [...] cat in_voltageY_raw at a 0.2s rate", I think it's not a far
> stretch to test 0.1s too. And it's actually quite odd (IMO) if 0.2s
> behaves *better* than 0.1s or 0.09s, just because it hits the parent's
> rpm_resume() more often.
>
> > > On Thu, Nov 05, 2026 at 12:59:24PM +0100, Rafael J. Wysocki (Intel) w=
rote:
> > > I would love to hear your counterarguments.
> >
> > OK, I'll say more about that tomorrow (it's past 10 PM here, time to
> > go away from the keyboard).
>
> Great! And don't rush on my account. I'm interested in eventual
> progress, even if not rapid. I'm sure you're busy.

Having to context-switch back to this later would probably be harder
than continuing it now.

> Or, maybe I should have gone to LPC...

I was busy all the time there though, so I guess no regrets at least
from that standpoint.

> > > I don't believe your solution solves the problem,
> >
> > That depends on what problem in particular you mean.
> >
> > It addresses an inconsistency in rpm_resume() and as I said above,
> > this needs to be done anyway because it is not only related to the
> > cases when children or consumers are involved.  There are other cases
> > in which rpm_resume() gets called for an active device and the lack of
> > last_busy update causes the device to suspend earlier than expected.
>
> Yes, on second thought, I agree that your patch addresses a real
> problem, even if it's not (IMO) quite a full solution for commit
> c537d3457542's.

No, it is not a full solution for this kind of a problem.

> > > and my solution does while also handling
> > > the inconsistency you mention.
> >
> > I'm not sure about that.
>
> Sorry, I see that part was inaccurate.

No worries.

> > For example, say a device has an autosuspend delay of 2 s.  Say it is
> > initially suspended and user space writes "on" to its "power/control",
> > so the device resumes.  Now, 1 s later, user space writes "auto" to
> > the device's "power/control" and the autosuspend delay is respected,
> > so the device doesn't suspend.  Next, 1.5 s after the first resume,
> > user space writes "on" to the device's "power/control" and the device
> > does not resume because it is active (its last_busy is not updated).
> > Finally, user space writes "auto" to the device's "power/control", say
> > 1 s later, and the device suspends even though it can be expected to
> > stay active for at least 1 s more.
> >
> > How is that going to be addressed by propagating last_busy from
> > children/consumers to parents/suppliers?
>
> Agreed, your patch addresses some scenarios mine doesn't.
>
> I also agree the power/control behavior is a bit awkward, although it's
> not very convincing to me as a use case.

Well, that was just the first example I could think about while
writing the above.

> (Arbitrary/periodic fiddling
> with power/control seems more like a nuisance API than a real expected
> use case.) Or if it were, I would suggest solving that by adding
> pm_runtime_mark_last_busy() to pm_runtime_allow() :)

Interesting thought, and hold on to it.

> To me, a more convincing one is: a non-autosuspending child with an
> autosuspending parent, in a situation otherwise similar to commit
> c537d3457542. The child is not likely to intentionally update last_busy,
> but only implicitly via rpm_resume(). When you solve the inconsistency
> with your patch, then it enables my patch to be more effective w.r.t.
> the parent.
>
> > Note that I'm not dismissing your proposal, I'm just having doubts
> > about the need to do this kind of thing in the core code.
>
> OK. I agree it adds a bit of complexity, but at the moment, it seems to
> me like the most thorough way to improve the ergonomics for clients
> (drivers) here. And that's pretty much my entire motivation here: to
> improve the ergonomics of runtime PM -- even if in this case, it
> requires a little (core) complexity.
>
> So, I'd love to hear what can make the ergonomics better here, with less
> core complexity.

Let me start with a clear problem statement to kind of refresh the context.

In some cases, there are unwanted parent suspends occurring between
child suspend and resume that delay the latter unnecessarily and
generally waste energy.  They mostly occur when the child suspends and
resumes relatively often and the parent's autosuspend delay is too
short to cover the entire period between the child suspend and resume
along with the preceding period of the child activity following the
most recent update of the parent's last_busy timestamp, at least
sometimes.

Of course, this also equally applies to suppliers and consumers, but
let's focus the attention on parents and children.

The problem addressed by

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dlinux-next&id=3D55b2b8af704f845e01fa2f31ee259b07641ce3a9

makes the unwanted parent suppends to occur more often because it
causes the parent to entirely miss its last_busy updates in the cases
when pm_runtime_resume() (or equivalent) is called for it when it is
active.  When this goes away, it should be possible to address those
"unwanted parent suspends" at least in some cases by increasing the
parent's autosuspend delay.  However, using larger autosuspend delay
values generally causes system power to grow (on average) because it
effectively causes devices to spend less time in suspend, so
increasing autosuspend delay values is not a particularly attractive
option.

Notice though that advancing the last_busy timestamp more often
without reducing the autosuspend delay values of the affected devices
is also likely to lead to the overall increase of system power because
it would effectively cause the devices to spend less time in suspend
(on average) likely increasing their power (unless the majority of
their suspends are unwanted).

Now, let me acknowledge that some drivers evidently want rpm_idle() to
always set the autosuspend timer instead of suspending the device
right away.  That may be because of the "unwanted parent suspends"
problem at hand or for other reasons.  Regardless, it is effectively
equivalent to setting last_busy in rpm_idle(), so they use their
.runtime_idle() callbacks for calling pm_runtime_mark_last_busy().  It
arguably would be nice to allow them to just declare that, for example
by introducing something like pm_runtime_use_autosuspend_always() to
be called instead of pm_runtime_use_autosuspend() if the driver wants
rpm_idle() to always set the autosuspend timer instead of attempting
to suspend the device directly.

I think that using pm_runtime_use_autosuspend_always(), if it existed,
might be attractive for a couple of reasons.  First off, which is
rather obvious, a driver using pm_runtime_use_autosuspend_always()
wouldn't need to worry about last_busy at all, so it would never need
to call pm_runtime_mark_last_busy() or pm_runtime_put_autosuspend().
It would just need to call pm_runtime_use_autosuspend_always() once
and set the autosuspend delay (which may even be combined with the
former).  Second, the autosuspend delay of a driver using
pm_runtime_use_autosuspend_always() would only need to cover the
period after the last runtime PM reference to the given device had
been dropped while currently an autosuspend delay needs to cover that
period along with some (usually unknown) period of device activity
between the most recent last_busy update and the time when rpm_idle()
gets called.  Thus, with pm_runtime_use_autosuspend_always(), the
autosuspend delay usage would be arguably more straightforward and
easier to reason about, and also the autosuspend delay might be
reduced in the majority of cases.

Of course, drivers that have the "unwanted parent suspends" problem
might switch over to using pm_runtime_use_autosuspend_always() and
adjust their autosuspend delay values to cover full periods of their
children's suspension.  In theory, it should be possible to reduce
their autosuspend delay values while at it, for reasons explained
above, so the total average system power might even remain unchanged
at least roughly.  That overall might be a zero-overhead change.

Using pm_runtime_use_autosuspend_always() would also make autosuspend
work consistently in all situations regardless of the reason why the
last runtime PM reference to the given device had been dropped,
including the "power/control" manipulations from user space, in which
case it would be equivalent to calling pm_runtime_mark_last_busy() in
the sysfs code path mentioned by you above.

Moreover, suppose that pm_runtime_use_autosuspend_always() turns out
to work for everybody, regardless of whether or not they have the
"unwanted parent suspends" problem.  In that case, it will be possible
to simplify the whole autosuspend delay handling quite a bit.
