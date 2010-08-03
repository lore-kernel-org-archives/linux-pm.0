From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 13:26:33 +0200
Message-ID: <20100803132633.7cb720df__15195.9472721957$1280834983$gmane$org@schatten.dmk.lab>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<20100802030304.GU2470@linux.vnet.ibm.com>
	<20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802074429.73a9dfd9@schatten.dmk.lab>
	<alpine.DEB.2.00.1008012303160.25170@asgard.lang.hm>
	<20100802084003.1c4c2bdb@schatten.dmk.lab>
	<20100802085332.23dd22f6@schatten.dmk.lab>
	<alpine.DEB.2.00.1008012355210.25170@asgard.lang.hm>
	<20100802092347.692dac32@schatten.dmk.lab>
	<alpine.DEB.2.00.1008020200450.25170@asgard.lang.hm>
	<AANLkTinGjktpuNi8062BQPegr4mofF6bx2EfBAsbOhCe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinGjktpuNi8062BQPegr4mofF6bx2EfBAsbOhCe@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Menage <menage@google.com>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Aug 2010 21:41:17 -0700
Paul Menage <menage@google.com> wrote:

> On Mon, Aug 2, 2010 at 2:06 AM,  <david@lang.hm> wrote:
> >
> > yes, it could mean a doubleing in the number of cgroups that you need on a
> > system. and if there are other features like this you can end up in a
> > geometric explosion in the number of cgroups.
> 
> No, it would be additive - you can mount different subsystems on
> separate hierarchies. So if you had X divisions for memory, Y
> divisions for CPU and Z divisions for suspend-blocking (where Z=2,
> probably?) you could mount three separate hierarchies and have X+Y+Z
> complexity, not X*Y*Z.
> 
> (Not that I have a strong opinion on whether cgroups is an appropriate
> mechanism for solving this problem - just that the problem you forsee
> shouldn't occur in practice).
> 
> Paul

Ah yes, mea culpa. I've got this wrong.

Cheers,
Flo
