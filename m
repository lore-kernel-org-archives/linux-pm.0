From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: Resume problem,
 reboot instead of resume after suspend on Zepto Nox A14
Date: Wed, 2 Nov 2011 18:39:06 +0900
Message-ID: <CAJ0PZbT6_64Sg6NX+-Kshdn0T-1zynyUVkZ-hRCYtz6Fv_v4CA@mail.gmail.com>
References: <CAEcrOvACd=zZ000t2niWM6DFgSuJOHyS1MEibwcA-=ouGfzU6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAEcrOvACd=zZ000t2niWM6DFgSuJOHyS1MEibwcA-=ouGfzU6w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Damien_Th=E9bault?= <damien.thebault@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 1, 2011 at 9:27 PM, Damien Th=E9bault
<damien.thebault@gmail.com> wrote:
> Hello,
>
> I have a problem with suspend and resume on my laptop, I tried to
> solve the problem myself but nothing works.
>
> I was using kernel 2.6.36 in the past and suspend was working just out
> of the box (however, I had problem with sound and needed a more recent
> kernel for it).
> With the next kernel, suspend was not working anymore, but I thought
> it was just a temporary bug.
> Some month later, I retried with a more recent kernel, and it still
> failed. So I bisected the problem and found that commit
> bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a was the first "bad" commit
> ("HID: hiddev: use usb_find_interface, get rid of BKL"). This commit
> made other laptops to fail suspend/resume too, and it was reverted
> later (commit 9c9e54a8df0be48aa359744f412377cc55c3b7d2 "HID: hiddev:
> fix memory corruption due to invalid intfdata").

9c9e54 does not revert bd25f4d. It provides "bugfix" for bd25f4d.
Thus, if this is due to a bug not addressed by 9c9e54 and there is a
bug that prevents S2RAM in bd25f4d, the problem will continue to
happen.

Have you tried to explicitly revert bd25f4d (and its successors of
hiddev.c) at 3.0.6?


> However, other changes must have been made elsewhere, and even after
> the revert, suspend didn't work anymore, and it's still not working
> now (3.0.6 currently).
>
> A lot of things changed in the kernel, and I don't expect to be able
> to solve my problem by looking at the git history, so I'm trying to
> solve the problem by using standard power-management debugging.
>
> First I'll describe the problem:
> =A0- I launch suspend to ram with any tool (I used to run acpitool -s,
> but echo mem > /sys/power/state or s2ram works too)
> =A0- The computer goes to sleep, the power led blinks slowly
> =A0- I push a keyboard key (usually Ctrl), but any key or the power key
> are working too
> =A0- Instead of resuming successfully, the computer reboots and the BIOS
> runs, like a cold power-up would do.
>
> I looked at Documentation/power/basic-pm-debugging.txt and tested
> modes of hibernations:
> =A0- echo freezer > /sys/power/pm_test
> =A0- echo mem > /sys/power/state
> This worked just fine, I then tested with "devices", "platform",
> "processors" and "core", and all worked.
> If I use "none" to use the normal suspend, it just reboots to the BIOS.

When core is used for pm_test, the platform_ops's enter() is not
called. Thus, you are not actually testing the real suspend-to-RAM,
you are testing everything suspend-related materials except for the
real suspend-resume mechanism for the CPU.

I'm not familiar with x86's ACPI; however, this looks like a
resume-related problem.
Probably, at the BIOS (or any other pre-BIOS stage?), the CPU cannot
read the "the system has been suspended-to-RAM" message?
or the resume routine of kernel is failing and the system resets or
jumps to BIOS?
, which are some issues we've experienced with ARM devices and its bootload=
ers.

You'll probably need to examine the ACPI's suspend-to-RAM related bits
or data structure at the platform_ops's enter() callback. And see if
anything is corrupted or mis-configured.


Anyway, having this hid device driver affecting suspend-to-RAM in such
a way seems very very odd...

Have you tried it with different compilers or different Kconfig options?

>
> I then followed the instructions at Documentation/power/s2ram.txt and
> used PM_TRACE:
> =A0- echo 1 > /sys/power/pm_trace
> =A0- echo mem > /sys/power/state
> On reboot, I can see the "Magic number" line, but no hash is matching.
>
> I then tried suspend to disk, everything works just fine there, it
> works perfectly.
>
> I searched on forums and mailing lists to see which quirks I could try:
> =A0- "i8042.reset=3D1": same behaviour
> =A0- "acpi_sleep=3Ds3_beep": same behaviour, no beep at all
> =A0- "acpi_sleep=3Dnonvs": same behaviour
> =A0- "no_console_suspend": same behaviour
>
> The DSDT does not contain any suspect windows-specific switches,
> there's some "windows 2006" checks, but nothing for other versions,
> and as I wrote previously linux was suspending well with the 2.6.36
> kernel.
> I'm not even sure that pressing a key does resume the kernel at all
> (since s3_beep doesn't do any sound and PM_TRACE doesn't show
> anything).
>
> What could I do to debug this further? Is there a list of parameters to t=
ry?
> What is the extra step done between "core" and "none" in /sys/power/pm_te=
st?
>
> This is a Zepto Nox A14 laptop, Core 2 Duo, ICH9 chipset, iwlagn wifi,
> ... I can provide dmidecode output, ACPI dumps and so on.
>
> Regards,
> --
> Damien Thebault
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
