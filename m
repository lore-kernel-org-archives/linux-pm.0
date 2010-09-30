From: Len Brown <lenb@kernel.org>
Subject: Re: Increased idle power on Atom netbook with 2.6.35 and
 intel_idle
Date: Thu, 30 Sep 2010 18:01:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009301757420.7033@localhost.localdomain>
References: <5563-1281493676-58384@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <5563-1281493676-58384@sneakemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Geoffrey Hausheer <w4ry27fpn4@snkmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> echo 0 > /sys/devices/system/cpu/cpu1/online

In 2.6.35 and before, this will lock cpu1 into C1 --
a shallow C-state that will have a negative impact on power
for the overall package.

A better test with that kernel is to disable HT in the BIOS
and then boot.

note that there is a fix in tip for this, as mentioned
in the bug report:

https://bugzilla.kernel.org/show_bug.cgi?id=5471

WRT intel_idle vs acpi_idle,
the best way to compare the two is with CONFIG_INTEL_IDLE=y
and boot with and without intel_idle.max_cstate=0
which disables intel_idle (and thus enables acpi_idle).

Re: 2.6.35 taking more power overall.
See if the wireless state has changed vs previous.
the powertop2 should help track down this kind of thing
when it becomes available.

thanks,
Len Brown, Intel Open Source Technology Center
