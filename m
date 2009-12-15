From: Salman Qazi <sqazi@google.com>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the Linux Kernel
Date: Mon, 14 Dec 2009 16:36:20 -0800
Message-ID: <4352991a0912141636t35a96c14o5fd4b9e152e6e681__40389.2900016674$1260893067$gmane$org@mail.gmail.com>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091214161922.6f252492@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 14, 2009 at 4:19 PM, Arjan van de Ven <arjan@infradead.org> wro=
te:
> On Mon, 14 Dec 2009 15:11:47 -0800
> Salman Qazi <sqazi@google.com> wrote:
>
>
> I like the general idea, I have one request (that I didn't see quite in
> your explanation): Please make sure that all cpus in the system do
> their idle injection at the same time, so that memory can go into power
> saving mode as well during this time etc etc...
>

With the current interface, the forced idle percentages on the CPUs
are controlled independently.  There's a trade-off here.  If we inject
idle cycles on all the CPU at the same time, our machine
responsiveness also degrades: essentially every CPU becomes equally
bad for an interactive task to run on.  Our aim at the moment is to
try to concentrate the idle cycles on a small set of CPUs, to strive
to leave some CPUs where interactive tasks can run unhindered.  But,
given a different workload and goals the correct policy may be
different.

Simultaneously idling multiple "cores" becomes necessary in the SMT
case: as there is no point in idling a single thread, while the other
thread is running full tilt.  So, in such a case it is necessary to
idle all the threads making up the physical core.  This feature has
not been implemented yet.

I think the best approach may be to provide a way to specify the
policy from the user space.  Basically let the user decide at what
level of CPU hierarchy the forced idle percentages are specified.
Then, in the levels below, we simply inject at the same time.

>
> --
> Arjan van de Ven =A0 =A0 =A0 =A0Intel Open Source Technology Centre
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>
