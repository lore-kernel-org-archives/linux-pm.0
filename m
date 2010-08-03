From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 21:56:10 -0700
Message-ID: <AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE__45067.0063881718$1280811590$gmane$org@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802011006.GS2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 1, 2010 at 6:10 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Sun, Aug 01, 2010 at 03:47:08PM -0700, Arjan van de Ven wrote:
...
>> Another one: freezing whole cgroups..... we have that today. it
>> actually works quite well.... of course the hard part is the decision
>> what to put in which cgroup, and at what frequency and duration you let
>> cgroups run.
>
> Indeed, the Android guys seemed to be quite excited by cgroup freezing
> until they thought about the application-classification problem.
> Seems like it should be easy for some types of applications, but I do
> admit that apps can have non-trivial and non-obvious dependencies.
>

The dependencies is what made this solution uninteresting to us. For
instance, we currently use cgroup scheduling to reduce the impact of
some background tasks, but we occasionally saw a watchdog restart of
the system process were critical services were waiting on a kernel
mutex owned by a background task for more than 20 seconds. If we froze
a cgroup instead, we would not hit this particular problem since tasks
cannot be frozen while executing kernel code the same way they can be
preempted, but nothing prevents a task from being frozen while holding
a user-space resource.

-- =

Arve Hj=F8nnev=E5g
