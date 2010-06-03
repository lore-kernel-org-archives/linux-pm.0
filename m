From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 16:30:49 +0200
Message-ID: <20100603163049.4eba1574__44246.9546724626$1275575511$gmane$org@schatten.dmk.lab>
References: <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org>
	<AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
	<20100603031842.GB11311@gvim.org>
	<AANLkTiks7sQBbDnN6QrtGVqSXLob1qCs7VA12LZAWnfM@mail.gmail.com>
	<20100603054018.GE11311@gvim.org>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
	<20100603132449.GA15595@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603132449.GA15595@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: 640e9920@gmail.com, Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Peter@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jun 2010 06:24:49 -0700
mark gross <640e9920@gmail.com> wrote:

> On Thu, Jun 03, 2010 at 12:10:03AM -0700, Arve Hj=F8nnev=E5g wrote:

> ok I'm not getting it.
> is this a fancy com-sci algorithm I should know about?
> =

> --mgross

I think you are at an advantage if you have studied fancy com-sci for
this? Here is an example:

say you have 5 constraints: =

qos1 with a value of 10
qos2 with 5
qos3 with 10
qos4 with 11

Now, you hash that list by the qos-values:

11    ---- 10 	----- 5 =

|	   |  	      |
qos4	   qos3       qos2
	   |
	   qos1


To compute the maximum you just walk the "----" list.

To reduce qos4 from 11 to 5 you remove it from its "|" list and
prepend it to the corresponding "|" list.  (4 Pointer adjustments +
searching the "-----" list for the right place to insert.  =


result:

10 ---- 5
|	|
qos3	qos4
|	|
qos1	qos2

Cheers,
Flo
