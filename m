From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Sat, 25 Mar 2017 00:52:03 +0100
Message-ID: <CAJZ5v0j4XiXP+oaoecG3BWy1iGkBXb+aB00nabGsrRMsN9n+DQ@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1831216.C7tcY13Jiv@aspire.rjw.lan> <20170315125957.GD18557@e110439-lin>
 <CAJZ5v0je7vPOrcAAu7jB6h+FDFMJZ048EZf4_Cemk2dvt-ffHA@mail.gmail.com>
 <CAJWu+opFdFYnKks8ywcbto1CAk=-k437bwzez-txp+8tRb3QzA@mail.gmail.com>
 <CAJZ5v0hyvL-hzpmM5TkEH4FRbJ1JyK4m7Q=urSO1F_Ghz8Vf4A@mail.gmail.com> <20170321110138.GA11054@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33915 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934525AbdCXXwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 19:52:06 -0400
In-Reply-To: <20170321110138.GA11054@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Joel Fernandes <joelaf@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Jonathan Corbet <corbet@lwn.net>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Tue, Mar 21, 2017 at 12:01 PM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 20-Mar 23:51, Rafael J. Wysocki wrote:

[cut]

>> So if you want to say "please don't sacrifice performance for these
>> top-apps" to it, chances are it will not understand what you are
>> asking it for. :-)
>
> Actually, this series are the foundation bits of a more complete
> solution, already in use on Pixel phones.
>
> While this proposal focuses just on "OPP biasing", some additional
> bits (not yet posted to keep things simple) exploit the Energy Model
> information to provide support for "task placement biasing".
>
> Those bits address also the concept of:
>
>    how much energy I want to sacrifice to get a certain speedup?

Well, OK, but this reads somewhat like "you can't appreciate that
fully, because you don't know the whole picture". :-)

Which very well may be the case and which is why I'm asking all of
these questions about the motivation etc.: I want to know the whole
picture, because I need context to make up my mind about this
particular part of it in a reasonable way.

[cut]

>> What you are saying generally indicates that you see under-provisioned
>> tasks and that's rather not because the kernel tries to sacrifice
>> performance for energy.  Maybe the CPU utilization is under-estimated
>> by schedutil or the scheduler doesn't give enough time to these
>> particular tasks for some reason.  In any case, having a way to set a
>> limit from user space may allow you to work around these issues quite
>> bluntly and is not a solution.  And even if the underlying problems
>> are solved, the user space interface will stay there and will have to
>> be maintained going forward.
>
> I don't agree on that point, mainly because I don't see that as a
> workaround. In your view you it seems that everything can be solved
> entirely in kernel space.

Now, I haven't said that and it doesn't really reflect my view.

What I actually had in mind was that the particular problems mentioned
by Joel might very well be consequences of what the kernel did even
though it shouldn't be doing that.  If so, then fixing the kernel may
eliminate the problems in question and there may be nothing left on
the table to address with the minimum capacity limit.

> In my view instead what we are after is a
> properly defined interface where kernel-space and user-space can
> potentially close a control loop where:
> a) user-space, which has much more a-priori information about tasks
>    requirements can feed some constraints to kernel-space.
> b) kernel-space, which has optimized end efficient mechanisms, enforce
>    these constraints on a per task basis.

I can agree in principle that *some* kind of interface between the
kernel and user space would be good to have in this area, but I'm not
quite sure about how that interface should look like.

It seems that what needs to be passed is information on what user
space regards as a reasonable energy-for-performance tradeoff,
per-task or overall.

I'm not convinced about the suitability of min/max capacity for this
purpose in general.

> After all this is not a new concept on OS design, we already have
> different interfaces which allows to tune scheduler behaviors on a
> per-task bias. What we are missing right now is a similar _per-task
> interface_ to bias OPP selection and a slightly improved/alternative
> way to bias task placement _without_ doing scheduling decisions in
> user-space.
>
> Here is a graphical representation of these concepts:
>
>       +-------------+    +-------------+  +-------------+
>       | App1 Tasks  ++   | App2 Tasks  ++ | App3 Tasks  ++
>       |             ||   |             || |             ||
>       +--------------|   +--------------| +--------------|
>        +-------------+    +-------------+  +-------------+
>                 |               |              |
>   +----------------------------------------------------------+
>   |                                                          |
>   |      +--------------------------------------------+      |
>   |      |  +-------------------------------------+   |      |
>   |      |  |      Run-Time Optimized Services    |   |      |
>   |      |  |        (e.g. execution model)       |   |      |
>   |      |  +-------------------------------------+   |      |
>   |      |                                            |      |
>   |      |     Informed Run-Time Resource Manager     |      |
>   |      |   (Android, ChromeOS, Kubernets, etc...)   |      |
>   |      +------------------------------------------^-+      |
>   |        |                                        |        |
>   |        |Constraints                             |        |
>   |        |(OPP and Task Placement biasing)        |        |
>   |        |                                        |        |
>   |        |                             Monitoring |        |
>   |      +-v------------------------------------------+      |
>   |      |               Linux Kernel                 |      |
>   |      |         (Scheduler, schedutil, ...)        |      |
>   |      +--------------------------------------------+      |
>   |                                                          |
>   | Closed control and optimization loop                     |
>   +----------------------------------------------------------+
>
> What is important to notice is that there is a middleware, in between
> the kernel and the applications. This is a special kind of user-space
> where it is still safe for the kernel to delegate some "decisions".

So having spent a good part of the last 10 years on writing kernel
code that, among other things, talks to these middlewares (like
autosleep and the support for wakelocks for an obvious example), I'm
quite aware of all that and also quite familiar with the diagram
above.

And while I don't want to start a discussion about whether or not
these middlewares are really as smart as the claims go, let me share a
personal opinion here.  In my experience, they usually tend to be
quite well-informed about the applications shipped along with them,
but not so much about stuff installed by users later, which sometimes
ruins the party like a motorcycle gang dropping in without invitation.

>> Also when you set a minimum frequency limit from user space, you may
>> easily over-provision the task and that would defeat the purpose of
>> what the kernel tries to achieve.
>
> No, if an "informed user-space" wants to over-provision a task it's
> because it has already decided that it makes sense to limit the kernel
> energy optimization for that specific class of tasks.
> It is not necessarily kernel business to know why, it is just required
> to do its best within the provided constraints.

My point is that if user space sets the limit to over-provision a
task, then having the kernel do the whole work to prevent that from
happening is rather pointless.

[cut]

>
>> >>> b) Capping the OPP selection for certain non critical tasks, which is
>> >>>    a major concerns especially for RT tasks in mobile context, but
>> >>>    it also apply to FAIR tasks representing background activities.
>> >>
>> >> Well, is the information on how much CPU capacity assign to those
>> >> tasks really there in user space?  What's the source of it if so?
>> >
>> > I believe this is just a matter of tuning and modeling for what is
>> > needed. For ex. to prevent thermal throttling as I mentioned and also
>> > to ensure background activities aren't running at highest frequency
>> > and consuming excessive energy (since racing to idle at higher
>> > frequency is more expensive energy than running slower to idle since
>> > we run at higher voltages at higher frequency and the slow of the
>> > perf/W curve is steeper - p = c * V^2 * F. So the V component being
>> > higher just drains more power quadratic-ally which is of no use to
>> > background tasks - infact in some tests, we're just as happy with
>> > setting them at much lower frequencies than what load-tracking thinks
>> > is needed.
>>
>> As I said, I actually can see a need to go lower than what performance
>> scaling thinks, because the way it tries to estimate the sufficient
>> capacity is by checking how much utilization is there for the
>> currently provided capacity and adjusting if necessary.  OTOH, there
>> are applications aggressive enough to be able to utilize *any*
>> capacity provided to them.
>
> Here you are not considering the control role exercised by the
> middleware layer.

Indeed.  I was describing what happened without it. :-)

[cut]

>
> Interesting discussion, thanks! ;-)

Yup, thanks!

Take care,
Rafael
