From: =?UTF-8?Q?Damien_Th=C3=A9bault?= <damien.thebault@gmail.com>
Subject: Resume problem,
	reboot instead of resume after suspend on Zepto Nox A14
Date: Tue, 1 Nov 2011 13:27:56 +0100
Message-ID: <CAEcrOvACd=zZ000t2niWM6DFgSuJOHyS1MEibwcA-=ouGfzU6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

I have a problem with suspend and resume on my laptop, I tried to
solve the problem myself but nothing works.

I was using kernel 2.6.36 in the past and suspend was working just out
of the box (however, I had problem with sound and needed a more recent
kernel for it).
With the next kernel, suspend was not working anymore, but I thought
it was just a temporary bug.
Some month later, I retried with a more recent kernel, and it still
failed. So I bisected the problem and found that commit
bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a was the first "bad" commit
("HID: hiddev: use usb_find_interface, get rid of BKL"). This commit
made other laptops to fail suspend/resume too, and it was reverted
later (commit 9c9e54a8df0be48aa359744f412377cc55c3b7d2 "HID: hiddev:
fix memory corruption due to invalid intfdata").
However, other changes must have been made elsewhere, and even after
the revert, suspend didn't work anymore, and it's still not working
now (3.0.6 currently).

A lot of things changed in the kernel, and I don't expect to be able
to solve my problem by looking at the git history, so I'm trying to
solve the problem by using standard power-management debugging.

First I'll describe the problem:
 - I launch suspend to ram with any tool (I used to run acpitool -s,
but echo mem > /sys/power/state or s2ram works too)
 - The computer goes to sleep, the power led blinks slowly
 - I push a keyboard key (usually Ctrl), but any key or the power key
are working too
 - Instead of resuming successfully, the computer reboots and the BIOS
runs, like a cold power-up would do.

I looked at Documentation/power/basic-pm-debugging.txt and tested
modes of hibernations:
 - echo freezer > /sys/power/pm_test
 - echo mem > /sys/power/state
This worked just fine, I then tested with "devices", "platform",
"processors" and "core", and all worked.
If I use "none" to use the normal suspend, it just reboots to the BIOS.

I then followed the instructions at Documentation/power/s2ram.txt and
used PM_TRACE:
 - echo 1 > /sys/power/pm_trace
 - echo mem > /sys/power/state
On reboot, I can see the "Magic number" line, but no hash is matching.

I then tried suspend to disk, everything works just fine there, it
works perfectly.

I searched on forums and mailing lists to see which quirks I could try:
 - "i8042.reset=1": same behaviour
 - "acpi_sleep=s3_beep": same behaviour, no beep at all
 - "acpi_sleep=nonvs": same behaviour
 - "no_console_suspend": same behaviour

The DSDT does not contain any suspect windows-specific switches,
there's some "windows 2006" checks, but nothing for other versions,
and as I wrote previously linux was suspending well with the 2.6.36
kernel.
I'm not even sure that pressing a key does resume the kernel at all
(since s3_beep doesn't do any sound and PM_TRACE doesn't show
anything).

What could I do to debug this further? Is there a list of parameters to try?
What is the extra step done between "core" and "none" in /sys/power/pm_test?

This is a Zepto Nox A14 laptop, Core 2 Duo, ICH9 chipset, iwlagn wifi,
... I can provide dmidecode output, ACPI dumps and so on.

Regards,
-- 
Damien Thebault
