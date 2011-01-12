From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/9] X86/perf: fix power:cpu_idle double end
	events and throw cpu_idle events from the cpuidle layer
Date: Wed, 12 Jan 2011 16:16:54 +0100
Message-ID: <201101121616.54613.trenn__24455.7082107805$1294845732$gmane$org@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-4-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120141330.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1101120141330.19140@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Robert Schoene <robert.schoene@tu-dresden.de>, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 January 2011 07:42:59 Len Brown wrote:
> I'm happy to see the trace point move up into cpuidle from intel_idle.
> 
> If somebody is picking this up in a perf tree,
> Acked-by: Len Brown <len.brown@intel.com>
> 
> else I can put it in the idle tree, let me know.
I didn't know you have an idle tree.

If you can push this one through the idle tree that would be great.

I'll go through the rest of my patches and resubmit
in some days as soon as some things are clarified.

But I need this one to still be included in .38.
Please tell me if this could be a problem.

Thanks,

  Thomas
