From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] perf_events: Enable idle state tracing for
 pseries (ppc64)
Date: Fri, 17 Jun 2011 14:24:19 +1000
Message-ID: <1308284659.32158.4.camel__21991.6516835385$1308284755$gmane$org@pasglop>
References: <20110601123554.GA12492@deepthi.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110601123554.GA12492@deepthi.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: deepthi@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-06-01 at 18:05 +0530, Deepthi Dharwar wrote:
> Hi,
> 
> Please find below a patch, which has perf_events added for pseries (ppc64)
> platform in order to emit the trace required for perf timechart. 
> It essentially enables perf timechart for pseries platfrom to analyse
> power savings events like cpuidle states.

Unless I'm mistaken, you added traces to dedicated CPU idle sleep but
not shared processor. Any reason ?

Also I don't really know that tracing stuff but what's the point of
having start/end _and trace_cpu_idle if you're going to always start &
end around a single occurence of trace_cpu_idle ?

Wouldn't there be a way to start/end and then trace the snooze and
subsequent cede within the same start/end section or that makes no
sense ?

Also would there be any interest in doing the tracing more generically
in idle.c ?

Cheers,
Ben.
