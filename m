From: saeed bishara <saeed.bishara@gmail.com>
Subject: questions about hibernate (swsusp)
Date: Wed, 14 Apr 2010 13:48:49 +0300
Message-ID: <m2qc70ff3ad1004140348xcdd00a2fs25250a99bd213e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
    I'm using kernel 2.6.32.9 on arm machine that has usb and mmc
interfaces. I've encounter the following issues:
1. when my swap partition on USB, the resume didn't detect the image,
this is because the usb disk is detected later than the
software_resume(), is there any way to overcome this problem.
meanwhile I succeeded to resume only when booting to initrd then
resuming using "echo <swap partition> /sys/power/resume". Is this the
only way to resume from usb?

2. when trying to enter hibernate state while mmc card is mounted, the
kernel hangs after suspending the devices. I was expecting the system
to refuse to enter hibernate rather than hanging while doing that. is
my expectation correct?

saeed
