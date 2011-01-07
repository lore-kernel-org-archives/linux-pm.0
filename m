From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 8/9] perf timechart: Map power:cpu_idle
	events to the corresponding cpuidle state
Date: Fri, 7 Jan 2011 11:52:11 +0100
Message-ID: <201101071152.11407.trenn__4828.10048056326$1294397867$gmane$org@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-9-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1294396190-23031-9-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-perf-users@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

Argh, forgot guilt refresh on this one.
The changelog could be a bit more detailed by adding:

On Friday 07 January 2011 11:29:49 Thomas Renninger wrote:
> Before, power:cpu_idle events were very specific X86 Intel mwait events.
> This got fixed with previous patches and cpu_idle events are now thrown by
> all cpuidle drivers and can be mapped to the corresponding cpuidle state
> in /sys.
> 
> This patch reads out the corresponding cpuidle name of a cpu_idle event
> and uses it in the title line of the chart (c-states Cx in x86, omap2
> - DDR self refresh states for various arm archs).
> 
> It also reads out the corresponding abbr(eviation) and uses the string
> to draw the cpu idle occurences. This needs a short (3 letter) string
> to keep the overview in the chart.

All features/fixes this patch includes:
  - Read up cpuidle events from sysfs if available
    and thus make them architecture independent
  - Use (free) green color to display idle events in the chart,
    red is also used by "Blocked IO" event(s)
  - Fix wrong class="rect.cX" to class="cX" idle box svg drawing
    definitions. This fixes up black idle drawings for eog (eye of gnome)
    and firefox (inkscape somehow could handle the broken case).

    Thomas
