From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 30 Aug 2006 09:26:46 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A95132@de01exm64.ds.mot.com>
References: <1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matthew.a.locke@comcast.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

 =

> From: Matthew Locke [mailto:matthew.a.locke@comcast.net] =

> ...
> > Could you say why you think [frequencies and sleep states]
> > shouldn't be mixed? Absent argument =

> > to the contrary, making it a single continuum seems appealing. Why =

> > have separate policies?
> =

> I know this questions is directed at Pavel but I have similar =

> concerns. =

>    I agree that making sleep states into operating points is =

> appealing.  =

> However,  if the implementation is just going to special case =

> the sleep state operating points then they should be handled =

> separately.  As Pavel points out, you can see from Dave's =

> implementation that the =

> operating point definition doesn't quite work for both.   Voltage and =

> frequency don't have meaning for the sleep points.  The per =

> point transition callbacks are needed just to handle the =

> sleep points.  =

> Latency has a very different meaning between the two types.  =

> Also,  the type field is required to identify which points =

> are sleep points and which ones are operating points.  I =

> think the concept of using operating points to define sleep =

> states could be a valid one but the implementation provided =

> isn't quite right (yet).
---

Well, if the object is to present "the right interface" to a user-space
policy manager, then I think the argument about whether the
implementations
are shared is irrelevant - the whole point would be to abstract away the
implementation, which could conceivably be separate hard-coded routines
for each operating point.  HOWEVER, the second part of your comment,
that the interface actually isn't right for describing sleep states, is
more compelling and might point a direction for future realignment (or
might just be grist for discussion now about the right attributes for
operating points. =


> ...
> =

> I think its more an issue with the implementation rather than =

> the concept.  We can't just have frequency and voltage as =

> shown in oppoint patches because we don't know which =

> frequency and voltage they refer to.  The number of frequency =

> and voltage parameters are completely dependent on the =

> hardware platform.
---

I agree that the set of parameters =

describing an OP should be flexible.

---
> =

> You bring up a more interesting area to look at integrating =

> sleep states and operating points.  Can we add some hooks =

> that allow us to define which operating point is selected at =

> resume?  Need to think about that a bit:)
---

It's an interesting question, and one we (Motorola) don't have hard
data to support, yet. Our current implementation remembers the OP
in use before sleeping and resumes at the same OP. The argument is
that this corresponds to an application that is doing work at a =

steady-state level (say decoding video), but that has a brief pause
to wait for I/O or a timer (say, pausing until the next frame time);
then it makes sense that the level of effort required on resume will
be the same as before sleeping.

Another possible approach would be to automatically resume at the =

highest OP, on the assumption that whatever wakes you up will be =

work to do, so you should be prepared to do it and then sink back =

to a lower OP as the workload diminishes. That argument is especially =

appropriate if you have a mechanism that aggregates timers or does =

periodic scheduling, so that you wake up less often, but do more =

work at each wakeup.

We're planning to do some research on this, but it's waiting for =

the infrequent time when there's a lull in product development work...

Scott
