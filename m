From: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Subject: Re: suspend works until core pm_test, but the still fails
Date: Mon, 15 Mar 2010 16:30:19 -0600
Message-ID: <4B9EB4FB.20201@maroy.hu>
References: <4B973F6B.4000709@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B973F6B.4000709@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I did some additional debugging on my issue below, namely booted the
kernel with the no_console_suspend and initcall_debug options and then:

echo 8 > /proc/sys/kernel/printk
rmmod xhci
echo mem > /sys/power/state

and then I got to the console, the last screen had messages like:

ACPI: Preparing to enter sleep state S3
Broke affinit for irq 25 (same for 26, 27 and 28)
CPU 1 is now offline (same for CPUs 1...8)
SMP alternatives: switching to UP mode
Extended CMOS year: 2000


and then the machine hangs, it doesn't power off.

this is on kernel 2.6.32.9

what could I do to make this work - e.g. the machine power off on
shutdown, and power off on suspend?


Akos
