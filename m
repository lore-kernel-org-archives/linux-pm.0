From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-rc2+: Interrupts enabled after cpufreq_suspend
Date: Thu, 16 Jul 2009 13:10:47 +1000
Message-ID: <1247713847.27937.14.camel__25922.5632450127$1247714015$gmane$org@pasglop>
References: <4A561074.5080407@gmail.com> <20090710192511.GB6240@redhat.com>
	<1247264617.21776.6.camel@pasglop> <20090710234646.GA11669@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090710234646.GA11669@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Marcin Slusarz <marcin.slusarz@gmail.com>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-07-10 at 19:46 -0400, Dave Jones wrote:

> The fail part comes from the fact that interrupts get reenabled.
> And that's something that can easily happen out of our control if
> we call into acpi_cpufreq's ->get method for example, so powernow-k8 isn't
> the sole reason.
> 
>  > I'm happy instead of #ifdef's however to push the logic into the ppc
>  > driver, or use a flag that the ppc driver sets to enable that logic.

So I'm not too familiar with what other platforms expect here, but would
it be ok to do something like bailing our early in cpufreq_suspend() if
there's no cpufreq_driver->suspend method ?

We would need to do the same on resume, though I do wonder whether there
could be a problem with even x86 here.. do we know for sure that we come
back from suspend with the same policy we had before suspending ? IE. We
should probably always do that check on resume, but we can't do it too
early due to irqs being off...

It's all because cpufreq is a sysdev which was imho a mistake in the
first place :-)

Maybe at this stage the best option is to add suspend_prepare and
resume_finish callbacks to sysdevs that are called while IRQs are still
on, and move cpufreq to use these instead ? That probably means we also
need to keep track that we have started suspend in the cpufreq core and
forbid attempts at changing policy etc... from either userspace of
on-demand governor while suspended, so that's more work, but could be
the best approach in the long run, what do you think ?

Otherwise I'm happy to just submit a patch that makes
cpufreq_suspend/resume bail out early if driver->suspend/resume are NULL
(or do you prefer a driver flag ?)

Cheers,
Ben.
