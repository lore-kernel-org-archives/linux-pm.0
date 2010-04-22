From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Fri, 23 Apr 2010 00:32:08 +0530
Message-ID: <20100422190208.GD10750__26877.8527890847$1271963031$gmane$org@dirshya.in.ibm.com>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
	<v2v8bb80c381004211832o88258fdez8e640ad9a45d11c0@mail.gmail.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <v2v8bb80c381004211832o88258fdez8e640ad9a45d11c0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: Salman <sqazi@google.com>, akpm@linux-foundation.org, ranjitm@google.com, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Mike Chan <mike@android.com> [2010-04-21 18:32:22]:

> On Thu, Apr 15, 2010 at 12:51 AM, Peter Zijlstra <peterz@infradead.org> w=
rote:
> > On Tue, 2010-04-13 at 17:08 -0700, Salman wrote:
> >> As we discussed earlier this year, Google has an implementation that it
> >> would like to share. =A0I have finally gotten around to porting it to
> >> v2.6.33 and cleaning up the interfaces. =A0It is provided in the follo=
wing
> >> messages for your review. =A0I realize that when we first discussed th=
is
> >> idea, a lot of ideas were presented for enhancing it. =A0Thanks alot f=
or
> >> your suggestions. =A0I haven't gotten around to implementing any of th=
em.
> >
> > .33 is way too old to submit patches against.
> >
> > That said, I really really dislike this approach, I would much rather
> > see it tie in with power aware scheduling.
> =

> I may have missed this on lkml but are there any on-going community
> efforts to power aware scheduling?

Yes, mostly in power aware task placement and task consolidation in
large SMP systems and also some timer consolidation to improve low
power idle residency.

There are some tuning and optimizations in cpuidle governor that is
related to power management but not core scheduler.

As Peter mentioned, most of them may not apply to uni processor
systems.

--Vaidy
