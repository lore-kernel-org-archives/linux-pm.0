From: Paul Menage <menage@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 21:38:12 -0700
Message-ID: <AANLkTikqMg+Syf3YooE9PtWD-S2nRemVcOitivUFU3OG__8347.39575298062$1280810370$gmane$org@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802085332.23dd22f6@schatten.dmk.lab>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 1, 2010 at 11:53 PM, Florian Mickler <florian@mickler.org> wrote:
>
> Thinking about it.. I don't know much about cgroups, but I think a
> process can only be in one cgroup at a time.

A thread can only be in one cgroup in each hierarchy at one time. You
can mount multiple cgroups hierarchies, with different resource
controllers on different hierarchies.

>
> b) you can't use cgroup for other purposes anymore. I.e. if you want to
> have 2 groups that each only have half of the memory available, how
> would you then integrate the cgroup-ignore-for-idle-approach with this?

You could mount the subsystem that provides the "ignore-for-idle"
support on one hierarchy, and partition the trusted/untrusted
processes that way, and the memory controller subsystem on a different
hierarchy, with whatever split you wanted for memory controls.

Paul
