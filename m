From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2/3] introduce intel_rapl driver
Date: Fri, 27 May 2011 21:56:35 +0200
Message-ID: <1306526195.2497.475.camel__27037.985440302$1306538753$gmane$org@laptop>
References: <1306398857.2207.157.camel@rui> <1306403003.1200.41.camel@twins>
	<1306484810.16581.375.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306484810.16581.375.camel@rui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matt Fleming <matt@console-pimps.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Corey Ashford <cjashfor@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "acme@redhat.com" <acme@redhat.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-05-27 at 16:26 +0800, Zhang Rui wrote:
> 
> > Currently there isn't a way to expose the events in sysfs, but we do
> > want that, its mostly a matter of getting all involved parties to agree
> > on a format and implementing it.
> > 
> I talked with Lin Ming just now, and he said that it should work in this
> way:
> First, only one pmu for RAPL interfaces, with four different kinds of
> events, pkg/core/uncore/dram,
> and the sysfs I/F is:
> /sys/bus/event_source/devices/rapl/---|---type
>                                       |---pkg
>                                       |---core
>                                       |---uncore
>                                       |---dram

Actually something like:

 /sys/bus/.../rapl/ -- | -- type
                       | -- events -- | -- pkg
                                      | -- core
                                      | ...

was one of the latest proposals, but then someone (can't remember who)
offered the opinion that having sub-groups of event might also be
wanted.

Furthermore a 'format' file was proposed which ought to contain a
description of how to compose a ::config value, but we never got around
to discussing a valid/useful syntax that could express all existing
cases (let alone be future proof).

> to use it, users can issue something like:
> perf stat -P rapl -e pkg/core/uncore/dram foo
> so that event->attr.type equals rapl_pmu.type and event->attr.config
> equals one of the rapl_domain_id.

Right, something like that, or simply something like -e rapl:pkg, which
again reminds me that people were working on a full EBNF syntax for the
-e argument.

> This sounds good. I can rewrite the code to work in this way, but it
> doesn't work for now, until both sysfs I/F and perf tool being ready,
> right? 

Right, so the only thing missing is the event bits (and some userspace
bits to use it all). The hardest part of it is getting those definitions
sorted, writing the patches shouldn't be too hard.
