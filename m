From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 4 Jun 2010 20:22:26 -0700
Message-ID: <20100605032226.GA20419__9813.65335542268$1275708185$gmane$org@gvim.org>
References: <20100601140519.GC1281@gvim.org>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org>
	<AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
	<20100603031842.GB11311@gvim.org>
	<AANLkTiks7sQBbDnN6QrtGVqSXLob1qCs7VA12LZAWnfM@mail.gmail.com>
	<20100603054018.GE11311@gvim.org>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
	<20100603132449.GA15595@gvim.org>
	<20100603163049.4eba1574@schatten.dmk.lab>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100603163049.4eba1574@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 03, 2010 at 04:30:49PM +0200, Florian Mickler wrote:
> On Thu, 3 Jun 2010 06:24:49 -0700
> mark gross <640e9920@gmail.com> wrote:
> =

> > On Thu, Jun 03, 2010 at 12:10:03AM -0700, Arve Hj=F8nnev=E5g wrote:
> =

> > ok I'm not getting it.
> > is this a fancy com-sci algorithm I should know about?
> > =

> > --mgross
> =

> I think you are at an advantage if you have studied fancy com-sci for
> this? Here is an example:
> =

> say you have 5 constraints: =

> qos1 with a value of 10
> qos2 with 5
> qos3 with 10
> qos4 with 11
> =

> Now, you hash that list by the qos-values:
> =

> 11    ---- 10 	----- 5 =

> |	   |  	      |
> qos4	   qos3       qos2
> 	   |
> 	   qos1
> =

> =

> To compute the maximum you just walk the "----" list.
> =

> To reduce qos4 from 11 to 5 you remove it from its "|" list and
> prepend it to the corresponding "|" list.  (4 Pointer adjustments +
> searching the "-----" list for the right place to insert.  =

> =

> result:
> =

> 10 ---- 5
> |	|
> qos3	qos4
> |	|
> qos1	qos2
> =

> Cheers,

Oh!  ok, thats easy!

Thanks!!!

--mgross
