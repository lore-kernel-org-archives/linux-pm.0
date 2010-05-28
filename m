From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 14:53:31 -0700
Message-ID: <AANLkTimqHZsm2g-yzl_XF0Wmtt9QZ9wfmLKaxJDWc5im__25.2868434928999$1275083670$gmane$org@mail.gmail.com>
References: <20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org> <4BFFB681.1000105@nokia.com>
	<AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	<4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org>
	<4BFFCFC7.7070302@nokia.com> <20100528142124.GA26733@srcf.ucam.org>
	<AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t@mail.gmail.com>
	<20100528160628.7c121dab@lxorguk.ukuu.org.uk>
	<AANLkTin3suKfGBSfiDj0n8ztY8UiHzr4af_Cr0SPOevY@mail.gmail.com>
	<20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, tytso@mit.edu, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 9:31 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I think Arve's concern was the representation of the "I care, but only
>> a little" or "just low enough to ensure threads must run" level which
>> is what suspend blockers would map to (low enough to ensure we
>> shouldn't halt the world but not necessarily implying a hard latency
>> constraint beyond that).
>
> That's why I suggested "manyana" (can't get accents for ma=F1ana in a
> define) or perhaps "dreckly"[1]. They are both words that mean "at some
> point" but in a very very vague and 'relax it'll happen eventually' sense.
>
> More importantly it's policy. It's a please meet this constraint guide
> to the PM layer - not a you must do as say even if its stupid.

Huh?

>
>> > They fix a general problem in terms of a driver specific item. We end =
up
>> > making changes around the tree but we make everyone happy not just
>> > Android. Also we are isolating policy properly. The apps and drivers s=
ay
>> > "I have these needs", the power manager figures out how to meet them.
>>
>> That makes sense -- and as I've mentioned elsewhere, we're really not
>> super picky about naming -- if it turns out that
>> wakelocks/suspendblockers were shorthand for "request a qos constraint
>> that ensures that threads are running", we'll be able to get things
>> done just as well as we do now.
>
> Cool. I think they are or at least they are close enough that nobody will
> notice the join ;)
>
>> > Where it gets ugly is if you start trying to have drivers giving an ap=
p a
>> > guarantee which the app then magically has to know to dispose of.
>>
>> Yeah -- which is something we've avoided in the existing model with
>> overlapping wakelocks during handoff between domains.
>
> I'm not sure avoided is the right description - its there in all its
> identical ugliness in wakelock magic
>
> If you treat QoS guarantees as a wakelock for your purposes (which is
> just fine, drivers and apps give you policy, you use it how you like)
> then you could write the paragraph below substituting the word
> 'guarantee' for 'wakelock' So in that sense the mess is the same because
> in both cases you are trying to suspend active tasks rather than asking
> the task to behave and then taking remedial action with offenders.
>
>> - input service is select()ing on input devices
>> - when select() returns it grabs a wakelock, reads events, passes them
>> on, releases the wakelock
>> - the event subsystem can then safely drop its "should be running
>> threads" constraint as soon as the last event is read because it has
>> no queues for userspace to drain, but the overlapping wakelock
>> prevents the system from immediately snapping back to sleep
>
> The conventional PC model is 'we don't go back into sleep proper fast
> enough for that race to occur'.

This is the same as saying these two threads don't run often enough to
need a mutex around their critical section. Just because you have not
been bitten by the race yet, does not mean it does not exist.

> It's hard to see how you change it. An

If each layer prevents suspend while it knows there are pending events
you don't have a race. Suspend blockers lets you do this.

> app->device "thank you for that event, I enjoyed it very much and have
> finished with it" message moves the underlying event management and QoS
> knowledge into he driver proper but doesn't really change the interface.
>
Yes you can do this, and it it how the android alarm driver works, but
we found the select()/poll(), block suspend, read event, process event
then unblock suspend sequence cleaner (especially for interfaces that
can return more than one event at a time). Kernel suspend blocker lets
you implement the alarm driver model, adding user-space suspend
blockers lets you implement the second.

>> > If you are prepared to exclude untrusted apps from perfectly reliable
>> > event reporting (ie from finger to application action) that doesn't se=
em
>> > to be a neccessity anyway.
>>
>> Currently in the Android userpace only trusted (system) apps can
>> directly obtain wakelocks -- arbitrary apps obtain them via rpc to a
>> trusted system service (which ensures the app has been granted
>> permission to do this and tracks usage for accountability to
>> user/developer).
>
> Clearly that would continue to work out.
>
> Alan
> [1] Dreckly being used in Cornwall, as one friend put it 'Like man=E3na b=
ut
> without that dreadful sense of urgency'
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
