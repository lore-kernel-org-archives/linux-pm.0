From: Melanie Kambadur <melanie@cs.columbia.edu>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Tue, 29 Oct 2013 12:25:32 -0400
Message-ID: <CAMeUXYtOURtQ4_iH4meuua2CWDiAFrKNYE9Zz2irYhAnt9AP8A@mail.gmail.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>
	<CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com>
	<CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>
	<526A82CC.1040709@gmail.com>
	<CAMeUXYvP+CKZKeU4WDeNSOJVDoe1hfB8G7k1fp7wG-wC2WeBUg@mail.gmail.com>
	<526A9092.5000800@gmail.com>
	<CAMeUXYv2d_1AUpAH7vBRisBnP6dKTrd3J-i5qYk8W-gZH1EdMg@mail.gmail.com>
	<526AB813.1080708@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <526AB813.1080708@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: David C Niemi <dniemi@verisign.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

After getting the chance to modify the BIOS, it finally looks like I
have the options that I want in terms of drivers/governors.

FYI, rmmod intel-pstate did not work (before or after modifying the
bios), and as I mentioned earlier, before updating the bios, setting
intel_pstate=disable erased most of my driver/governor options.  What
did work was to update the BIOS to OS control as suggested, and THEN
setting intel_pstate=disable gave me the acpi-cpufreq driver, along
with the following governors:

On Fri, Oct 25, 2013 at 2:27 PM, David C Niemi <dniemi@verisign.com> wrote:
>
> I'm pretty sure that Dell's Active Power Controller would supersede what the intel-pstate driver/governor is trying to do as well.  I doubt you will have enough control over the box to do meaningful tests until you can get the BIOS power setting changed to "OS Control".
>
> speedstep and p4-clockmod are both ancient.  But it is all moot if the BIOS won't let the OS manage the CPU.
>
> It is possible your distribution is a bit too stripped down.  You might want to build and install your own kernel so you can make sure all the sensible options are in it.  But it is also possible acpi-cpufreq is built in so you don't see it as a module, and it is not possible to activate it due to the Active Power Controller getting in the way.
>
> Meanwhile, can you rmmod intel-pstate?
>
> DCN
>
> On 10/25/13 12:35, Melanie Kambadur wrote:
>> If I disable intel_pstate on my kernel command line, I end up with
>> access only to the speedstep and p4-clockmod drivers, and no
>> acpi-cpufreq driver.  Is there a way to download the acpi-cpufreq
>> driver? I've tried a couple of things without success.
>>
>> BTW, I haven't gotten the chance to modify the BIOS yet (waiting on a
>> sysadmin).
>> -Melanie
