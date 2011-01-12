From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/9] X86/perf: fix power:cpu_idle double end
 events and throw cpu_idle events from the cpuidle layer
Date: Wed, 12 Jan 2011 01:42:59 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120141330.19140__27025.632086634$1294814658$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294396190-23031-4-git-send-email-trenn@suse.de>
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Robert Schoene <robert.schoene@tu-dresden.de>, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

I'm happy to see the trace point move up into cpuidle from intel_idle.

If somebody is picking this up in a perf tree,
Acked-by: Len Brown <len.brown@intel.com>

else I can put it in the idle tree, let me know.

thanks,
Len Brown, Intel Open Source Technology Center
