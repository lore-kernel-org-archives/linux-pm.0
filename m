From: David C Niemi <dniemi@verisign.com>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Tue, 11 Nov 2014 14:46:39 -0500
Message-ID: <5462679F.6080303@verisign.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com> <CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com> <CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com> <526A82CC.1040709@gmail.com> <CAMeUXYvP+CKZKeU4WDeNSOJVDoe1hfB8G7k1fp7wG-wC2WeBUg@mail.gmail.com> <526A9092.5000800@gmail.com> <CAMeUXYv2d_1AUpAH7vBRisBnP6dKTrd3J-i5qYk8W-gZH1EdMg@mail.gmail.com> <526AB813.1080708@verisign.com> <CAMeUXYtOURtQ4_iH4meuua2CWDiAFrKNYE9Zz2irYhAnt9AP8A@mail.gmail.com> <CAMeUXYvOTA4FXOo_mZKqeGnC_EhjBNMAsks41p0kx8YHXt9Cew@mail.gmail.com> <526FEA65.2030301@gmail.com> <CAMeUXYswoEhNbVua6wV-qg_DL5mn5Eahdny12wvSbs02h16RBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:58017 "EHLO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaKKUVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 15:21:51 -0500
Received: from DUL1WNSMTP01.vcorp.ad.vrsn.com (dul1wnsmtp01.vcorp.ad.vrsn.com [10.170.12.113])
	by brn1lxmailout01.verisign.com (8.13.8/8.13.8) with ESMTP id sABJkeKo008469
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2014 14:46:41 -0500
In-Reply-To: <CAMeUXYswoEhNbVua6wV-qg_DL5mn5Eahdny12wvSbs02h16RBQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Melanie Kambadur <melanie@cs.columbia.edu>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>


Hello Melanie,

The results are interesting but in some cases not very surprising.

An interesting finding is that disabling Turbo mode does not save a measurable amount of power.

The Powersave governor has a much poorer showing than Ondemand in the study's results.  Ondemand has aged fairly well considering the focus of power savings has changed considerably since it was first written.  As you noticed the default Ondemand configuration is not very optimal for either power savings or performance -- its default settings are designed to mimic the behavior of oldest versions of Ondemand.  But Ondemand can be tuned to do far better at both -- on servers I typically use UP_THRESHOLD=15 and SAMPLING_DOWN_FACTOR=100, which matches the Turbo-enabled Performance governor's performance on all loads I've tested and occasionally exceeds it, while saving noticeable amount of power if there are periods of idleness between activities (which is nearly always the case in real-world 
 use).  Ondemand has been adapted with tweaks and minor changes to dozens of portable systems as well.  On specific architectures and applications there is usually something better to do, but
it is hard to find a better general purpose approach.

With respect to idle states, there are options far inbetween idle=on and idle=off.  Permitting very deep sleep states like C6 is really only useful on laptops or other portable devices and can be expected to hurt performance in many applications.  But utterly disabling idle states like C1/C1E/C3 can actually be counterproductive to performance (by wasting more of your thermal envelope on idle cores), while greatly increasing power consumption.

Nowadays, the use of the intel_pstate combined driver/governor is increasing -- it would be nice to see it compared.

David C Niemi

On 11/11/14 14:13, Melanie Kambadur wrote:
> Hi all, 
>
> It has been over a year since I wrote to you with questions about cpufreq and cpuidle, but I wanted to let you know that your comments helped me conduct a large-scale, "experimental survey" on energy efficiency that was recently published at OOPSLA <http://2014.splashcon.org/track/oopsla2014>.
>
> The paper, "An Experimental Survey of Energy Management Across the Stack"
>  (http://arcade.cs.columbia.edu/energy-oopsla14.pdf), compares and combines the power and energy effects of the linux idle and frequency drivers, as well as parallelism, overclocking, compiler optimizations, RAPL caps, and software modifications across 41 applications from 5 benchmark suites.  
>
> I thought some people on this list might be interested in the results. Please let me know if you have any comments or questions.
>
> Thanks again for your help!
>
> -Melanie
>
> On Tue, Oct 29, 2013 at 1:03 PM, Dirk Brandewie <dirk.brandewie@gmail.com <mailto:dirk.brandewie@gmail.com>> wrote:
>
>     On 10/29/2013 09:27 AM, Melanie Kambadur wrote:
>
>         Apologies, I accidentally sent my last mail before finishing...
>
>         The available governors I have now are:
>         conservative ondemand userspace powersave performance.
>
>
>     Only ondemand will have any active control of the P state requested.
>
>     performance == highest P state (reported by ACPI) is requested
>     powersave   == lowest P state (reported by ACPI) is requested
>     userspace   == Allows the user select a single P state.
>
>     With intel_pstate enabled
>     performance == highest P state (enumerated form CPU) is requested.
>     powersave   == Active control of the P state similar to ondemand.
>
>     To get userspace governor behavior set
>     /sys/devices/system/cpu/intel_pstate/{min, max}_perf_pct to the same
>     values.
>
>     /sys/devices/system/cpu/intel_pstate/no_turbo allows you to configure
>     whether P states in the turbo range for your CPU will be selected.
>
>
>         Thankfully, I did not have to modify my kernel at all to get these.
>         Once I get the chance to run some tests, I will keep you posted as to
>         whether the governors behave as documented with this new
>         configuration.
>
>         Thanks again for the pointers and suggestions that got me this far!
>
>         Melanie
>
>         On Tue, Oct 29, 2013 at 12:25 PM, Melanie Kambadur
>         <melanie@cs.columbia.edu <mailto:melanie@cs.columbia.edu>> wrote:
>
>             After getting the chance to modify the BIOS, it finally looks like I
>             have the options that I want in terms of drivers/governors.
>
>             FYI, rmmod intel-pstate did not work (before or after modifying the
>             bios),
>
>
>     intel_pstate is built-in only and not a module :-)
>
>             and as I mentioned earlier, before updating the bios, setting
>             intel_pstate=disable erased most of my driver/governor options.
>
>
>     The cpufreq core creates the sysfs files as governors are registered
>     with the core.  With intel_pstate=disable the driver will not register
>     with the core so if no other drivers/governors register with the core
>     the sysfs files will be missing.
>
>
>             What
>             did work was to update the BIOS to OS control as suggested, and THEN
>             setting intel_pstate=disable gave me the acpi-cpufreq driver, along
>             with the following governors:
>
>             On Fri, Oct 25, 2013 at 2:27 PM, David C Niemi <dniemi@verisign.com <mailto:dniemi@verisign.com>> wrote:
>
>
>                 I'm pretty sure that Dell's Active Power Controller would supersede what the intel-pstate driver/governor is trying to do as well.  I doubt you will have enough control over the box to do meaningful tests until you can get the BIOS power setting changed to "OS Control".
>
>                 speedstep and p4-clockmod are both ancient.  But it is all moot if the BIOS won't let the OS manage the CPU.
>
>                 It is possible your distribution is a bit too stripped down.  You might want to build and install your own kernel so you can make sure all the sensible options are in it.  But it is also possible acpi-cpufreq is built in so you don't see it as a module, and it is not possible to activate it due to the Active Power Controller getting in the way.
>
>                 Meanwhile, can you rmmod intel-pstate?
>
>                 DCN
>
>                 On 10/25/13 12:35, Melanie Kambadur wrote:
>
>                     If I disable intel_pstate on my kernel command line, I end up with
>                     access only to the speedstep and p4-clockmod drivers, and no
>                     acpi-cpufreq driver.  Is there a way to download the acpi-cpufreq
>                     driver? I've tried a couple of things without success.
>
>                     BTW, I haven't gotten the chance to modify the BIOS yet (waiting on a
>                     sysadmin).
>                     -Melanie
>
>
>


