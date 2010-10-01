From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 1 Oct 2010 17:50:25 +0200
Message-ID: <AANLkTimScOT8yJV5i2F7Hi5rhrsupz-K1oOYnzitn5CQ__1849.35474903813$1285948287$gmane$org@mail.gmail.com>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<1285945464-10884-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285945464-10884-2-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

The patch looks good to me.

A few remarks though:

On Fri, Oct 1, 2010 at 5:04 PM, Thomas Renninger <trenn@suse.de> wrote:
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
> =A0power:power_start
> =A0power:power_end
> are replaced with:
> =A0power:processor_idle
>
> and
> =A0power:power_frequency
> is replaced with:
> =A0power:processor_frequency
>
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.
The suspend trace points are not present in the patch. As Rafael
suggested the best place for the trace point is at
kernel/power/suspend.c:suspend_enter(), so it fits all platforms.
Also it is good to note that the cpu_id field has been removed from
the suspend trace point prototype.

> the type=3D field got removed from both, it was never
> used and the type is differed by the event type itself.
As proposed recently I think an extra parameter is needed, to return a
sub-state, a return code, the real HW state... Is it possible to add
it?

> perf timechart
> userspace tool gets adjusted in a separate patch.
I am preparing a patch to pytimechart and will submit it as soon as
the kernel code gets merged in.

Thanks!

Jean
