From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: Make cpuidle_enable_device() call
	poll_idle_init()
Date: Mon, 10 Jan 2011 17:49:07 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101101747530.7945__25955.5843811997$1294699825$gmane$org@x980>
References: <201101080029.20744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201101080029.20744.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

works for me!

/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:1715
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:8

becomes

/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:C0
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:28716
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:11

thanks,
Len Brown, Intel Open Source Technology Center
