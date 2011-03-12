From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended
 with quite some features
Date: Sat, 12 Mar 2011 12:34:09 +0800
Message-ID: <20110312043409.GA3634__17670.340013183$1300115628$gmane$org@zhy>
References: <201103111247.00212.trenn@suse.de>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103111247.00212.trenn@suse.de>
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
Cc: Mattia Dongili <malattia@linux.it>, dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, linux@dominikbrodowski.net, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, power@bughost.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 11, 2011 at 12:46:59PM +0100, Thomas Renninger wrote:
> Happy testing..., if you have a recent machine, you'll like it!
> 
> After some testing phase it would be great to get this tool
> merged into the kernel git repo under:
> tools/power/cpupower
> and replace the Intel HW only supporting tools in tools/power/x86.

I got below output on my laptop:

    |Mperf               || Idle_Stats                
CPU | C0   | Cx   | Freq || POLL | C1   | C2   | C3   
   0| 36.00| 64.00|   820||1843411670376227.2|1843411670376692.2|  0.00|  0.00
   1| 44.69| 55.31|   920||  0.00|  0.00|  0.00|  0.00

Seems below patch fix it:

Thanks,
Yong

---
--- utils/helpers/sysfs-orig.c	2011-03-12 12:32:06.179827929 +0800
+++ utils/helpers/sysfs.c	2011-03-12 12:24:36.865599924 +0800
@@ -126,7 +126,7 @@
 		return 0;
 	}
 
-	value = strtoul(linebuf, &endp, 0);
+	value = strtoull(linebuf, &endp, 0);
 
 	if ( endp == linebuf || errno == ERANGE )
 		return 0;
