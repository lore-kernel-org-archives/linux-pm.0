From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 30 Aug 2006 09:39:44 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A9514B@de01exm64.ds.mot.com>
References: <2b520e23c76213a4954c9b97c5df7012@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <2b520e23c76213a4954c9b97c5df7012@comcast.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matthew.a.locke@comcast.net>, David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

 =

> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Matthew Locke

> Latency is a good example of how mixing sleep states with =

> operating points doesn't  quite work.  Latency for switching =

> to a new operating =

> point is very a much a function of the current operating point.   I =

> think latency for sleep states is the same every time.  Also =

> which direction are you capturing latency for, suspend or =

> resume?  If your power manager is making decisions based on =

> latency, I could imagine that it needs to know the latency =

> for going into and out of that state.
---

Well, you could also argue that the ability to express latency is =

a good argument for having an approach that does mingle frequency-based,

voltage-based, and sleep-state Ops, though not necessarily exactly =

what oppoint does! That is, if the policy manager is to make good =

decisions about whether to shift to a different frequency or sleep =

at one of n possible sleep levels, it would exactly want to be able =

to consider the alternatives in terms of the expected time and power =

cost of each possible transition and whether the expected time to =

remain in that state would be sufficient to recoup those costs.

That is, you'd like a big state-transition table that has a tuple of =

costs associated with each possible transition from each possible state.

The utility of the expected times, of course, depends on whether you =

are able to infer anything about how long an idle (or low-work) =

period is likely to persist. I think this is a fertile area for =

experimentation, though we haven't had time to do it, yet.  And, =

while it's superficially easier to take on for embedded devices =

that have limited numbers of states, the notion of a system manager =

that watches work patterns and their corresponding load levels and =

idle times is not particularly far-fetched.

On the other hand, getting infrastructure in place is more =

important, today! But, that said, if user-space interfaces =

are forever, you would like to present a user-space interface =

that can be easily extended to support such notions in the future, =

without breaking compatibility.

Scott
