From: Salman Qazi <sqazi@google.com>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Mon, 19 Apr 2010 10:20:01 -0700
Message-ID: <h2u4352991a1004191020q8200399oc8e9f7d8dee934bf__46114.255153998$1271697677$gmane$org@mail.gmail.com>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1271317886.32749.69.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 15, 2010 at 12:51 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> On Tue, 2010-04-13 at 17:08 -0700, Salman wrote:
>> As we discussed earlier this year, Google has an implementation that it
>> would like to share. =A0I have finally gotten around to porting it to
>> v2.6.33 and cleaning up the interfaces. =A0It is provided in the followi=
ng
>> messages for your review. =A0I realize that when we first discussed this
>> idea, a lot of ideas were presented for enhancing it. =A0Thanks alot for
>> your suggestions. =A0I haven't gotten around to implementing any of them.
>
> .33 is way too old to submit patches against.

Will bump up the version when I refresh the change.

>
> That said, I really really dislike this approach, I would much rather
> see it tie in with power aware scheduling.

I think I can see your point:  there is potentially better information
about the power consumption of the CPU beyond the time it was busy.
But please clarify: is your complaint the lack of use of this
information or are you arguing for a deeper integration into the
scheduler (I.e. implementing it as part of the scheduler rather than
an independent thread) or both?

>
>
