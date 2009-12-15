From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Mon, 14 Dec 2009 17:06:16 -0800
Message-ID: <20091214170616.59fc163f__11082.3244591758$1260839111$gmane$org@infradead.org>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
	<4352991a0912141636t35a96c14o5fd4b9e152e6e681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4352991a0912141636t35a96c14o5fd4b9e152e6e681@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2009 16:36:20 -0800
Salman Qazi <sqazi@google.com> wrote:

> On Mon, Dec 14, 2009 at 4:19 PM, Arjan van de Ven
> <arjan@infradead.org> wrote:
> > On Mon, 14 Dec 2009 15:11:47 -0800
> > Salman Qazi <sqazi@google.com> wrote:
> >
> >
> > I like the general idea, I have one request (that I didn't see
> > quite in your explanation): Please make sure that all cpus in the
> > system do their idle injection at the same time, so that memory can
> > go into power saving mode as well during this time etc etc...
> >
> 
> With the current interface, the forced idle percentages on the CPUs
> are controlled independently.  There's a trade-off here.  If we inject

I'm fine with that... just want to ask that even if we inject different
percentages, that we inject them for maximum overlap
(having the memory power in a machine suddenly be half or less is a
huge step in power, for something, the alignment itself, that does not
cost much if any extra performance over randomly distributed idle
insertions)

> idle cycles on all the CPU at the same time, our machine
> responsiveness also degrades: essentially every CPU becomes equally
> bad for an interactive task to run on.  Our aim at the moment is to
> try to concentrate the idle cycles on a small set of CPUs, to strive
> to leave some CPUs where interactive tasks can run unhindered.  But,
> given a different workload and goals the correct policy may be
> different.

as long as the tentative portion of the idle time gets injected at the
same time.. I suspect there can be a decent balance here where most of
the time we get the full CPU *and* memory savings, while we degrade
gracefully for the case where we get increasingly more interactive
activity.

 
> Simultaneously idling multiple "cores" becomes necessary in the SMT
> case: as there is no point in idling a single thread, while the other
> thread is running full tilt.  

I can argue the same for package level btw ;)


> I think the best approach may be to provide a way to specify the
> policy from the user space.  Basically let the user decide at what
> level of CPU hierarchy the forced idle percentages are specified.
> Then, in the levels below, we simply inject at the same time.

it's not so much about the specification part; per logical cpu is a nice
place to specify things... as long as we, in the execution part, align
things up smart.




-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
