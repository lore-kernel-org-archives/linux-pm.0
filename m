From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Mon, 14 Dec 2015 17:14:59 +0100
Message-ID: <48DF4267-671B-40E2-8C95-CCF5795F8B26@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26490 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbbLNQPN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 11:15:13 -0500
In-Reply-To: <2402797.hEhmBtxRMB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Renninger <trenn@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

We are currently re-doing the measurement on our latest android release.

Here are the results we have on a android release of WW50
Note that as of today Android is using Interactive Governor.

Atom:                              Intel PState   Intel PState     Power
                                   Performance    CPU Load      Improvment

Circular Progressbar (animation)      136 mW         32 mW        -76%
50% Load 1 thread                     260 mW         25 mW        -90%
T-Rex (gaming)                        500 mW        302 mW        -40%
Application Install                   799 mW        383 mW        -52%
Music Playback (AAC)                   87 mW         33 mW        -62%
iozone                                819 mW        104 mW        -87%
CandyCrush                            415 mW        130 mW        -69%
FruitNinja                           1007 mW        853 mW        -15%
Plants vs zombie2                     356 mW        101 mW        -71%
AngryBirds                            344 mW        100 mW        -70%
VideoPlayBack                         549 mW        124 mW        -77%
Browsermark                           759 mW        560 mW        -26%
IcyRocks                              589 mW        486 mW        -17%



Atom:                       Intel PState  Intel PState   Performance
                            Performance     CPU Load     Improvment

AndEBench-Native                21585       21737       0.70%
AndEBench-Java                  1630        1632        0.12%
SmartBench-Gaming               4312        4292        -0.46%
SmartBench-Productivity         15484       15441       -0.28%
Dhrystone                       37506       37444       -0.16%
CoreMark                        35259       35231       -0.08%
Quadrant-2D                     1000        1000        0.00%
Quadrant-3D                     2478        2465        -0.52%
Quadrant-IO                     9997        9917        -0.80%
Quadrant-Mem                    14839       15159       2.16%
0xBenchLinpack4T                193         192         -0.70%
CaffeineMark                    51955       51746       -0.40%
GeekBench-Integer               4514        4507        -0.16%
GeekBench-Score                 3403        3378        -0.73%
GeekBench-FloatingPoint         3247        3245        -0.06%
GeekBench-Memory                1540        1538        -0.13%
CFBench-Native                  38585       39003       1.08%
AnTuTu-DB                       770         745         -3.25%
AnTuTu-2D                       1657        1654        -0.18%
AnTuTu-3D                       20133       19961       -0.85%
AnTuTu-Dalvik                   4336        4352        0.37%
AnTuTu-Int-single               2244        2244        0.00%
AnTuTu-Multitask                8693        8164        -6.09%
AnTuTu-Float-single             2228        2226        -0.09%
AnTuTu-Ram                      3425        3447        0.64%
AnTuTu-IO                       2467        2442        -1.01%
AnTuTu-Mem                      2532        2528        -0.16%
AnTuTu-Int                      4882        4901        0.39%
AnTuTu-Total                    58198       57631       -0.97%
AnTuTu-Float                    4831        4904        1.51%
CompuBenchRS-Gauss              45          43          -4.84%
CompuBenchRS-Particule          57          42          -26.89%
CompuBenchRS-Fractal            157         149         -5.46%
CompuBenchRS-Raytrace           10          10          -1.21%
CompuBenchRS-Histogram          85          77          -9.20%
CompuBenchRS-Gaussintr          47          44          -7.28%
CompuBenchRS-Facedetect         5           5           -0.64%
Kraken-Score                    4125        4136        0.27%
Octane-Score                    8026        8098        0.90%
Sunspider-Score                 660         673         1.98%
AnTuTu-Dalvik                   2605        2642        1.42%
AnTuTu-Int-single               2343        2388        1.92%
AnTuTu-Multitask                2082        2135        2.55%
Stream-Copy                     6704        6705        0.01%
Stream-Scale                    6530        6527        -0.06%
IOZone RR                       4656        4278        -8.12%  Intel P-State performance, is relatively imune to I/O Wait
IOZone RW                       1256        836         -33.44% Intel P-State performance, is relatively imune to I/O Wait
BrowserMark                     2071        2086        0.72%
jArt                            689 ops/sec 685 ops/sec -0.54%


--
Steph




> On Dec 10, 2015, at 11:01 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
>> On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
>>> On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
>>>> On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
>>>>> On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> 
> [cut]
> 
>>> 
>>> This is the order I am thinking of in the order of priority high to
>>> low :
>>> - User policy (either command line or via cpu-freq scaling_governor)
>>> - ACPI
>>> - Pickup defaults based on CPU ID.
>> 
>> Why by CPU ID?
> 
> For a couple of reasons.
> 
> First of all, processors are designed in a specific way and some ways of
> P-states management may not lead to good results on them no matter what,
> while others may match them a lot better.
> 
> The processors in question here are designed with energy efficiency in mind.
> For this reason, an approach skewed towards performance (which the original
> algorithm in intel_pstate is) is really suboptimal there as the performance
> is not there in the first place, quite fundamentally.  Even if anyone used
> any chip based on those cores in a server, that would be a "low-power server"
> so to speak, so using an algorithm more oriented towards energy efficiency
> would still make sense for it.
> 
> Second, the CPU ID is the most reliable piece of information about the
> type of the system we can possibly get.  The BIOS may always lie to us and
> we can't entirely rely on it for figuring out the system profile, but as I
> said, if a CPU designed for energy-efficient systems is used in the given
> one, that is a strong indication on what the system is or it would have
> used a different CPU otherwise.
> 
>> This doesn't make sense to me and unnecessarily complicates
>> things.
>> 
>> But, please do not submit anything half baken:
>> a new pstate ondemand governor or different
>> workload optizmized algorithms inside this governor, or later possibly as
>> separate governors, defaults based on CPU ID or platform type and
>> then later userspace tunable...
>> 
>> We should not only think, but implement a final concept and submit altogether.
>> Otherwise there are several kernels flying around which do implement half
>> of the implementation and the confusion is perfect.
> 
> On the other hand, making changes in smaller steps allows us to use a more
> evolutionary approach in which changes that turn out to cause problems to
> happen may be easily reverted and replaced with something better.
> 
>> I would also be interested in some figures.
>> Are there any measurements how many power is saved, how big the performance
>> overhead is, etc?
> 
> Philippe will provide the data.
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

