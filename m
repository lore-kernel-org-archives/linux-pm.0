From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Wed, 21 Apr 2010 18:32:22 -0700
Message-ID: <v2v8bb80c381004211832o88258fdez8e640ad9a45d11c0__47879.5815528885$1271900027$gmane$org@mail.gmail.com>
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
Cc: Salman <sqazi@google.com>, akpm@linux-foundation.org, dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
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
>
> That said, I really really dislike this approach, I would much rather
> see it tie in with power aware scheduling.

I may have missed this on lkml but are there any on-going community
efforts to power aware scheduling?

-- Mike

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
