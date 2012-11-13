From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: RE: [PATCH 3/6 v4] cpufreq: tolerate inexact values when collecting
 stats
Date: Tue, 13 Nov 2012 14:13:38 -0500
Message-ID: <21672683C5A3814BB4DB938EBE482DE426EA988080@IAD2MBX09.mex02.mlsrvr.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-4-git-send-email-mark.langsdorf@calxeda.com>
 <20121111163821.GA21635@x1.osrc.amd.com> <50A12565.4070701@calxeda.com>
 <20121113162449.GE9327@x1.osrc.amd.com>,<50A2766D.6040008@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <50A2766D.6040008@calxeda.com>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>, Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: linux-pm-owner@vger.kernel.org [linux-pm-owner@vger.kernel.org] On Behalf Of Mark Langsdorf [mark.langsdorf@calxeda.com]

> On 11/13/2012 10:24 AM, Borislav Petkov wrote:
>> On Mon, Nov 12, 2012 at 10:35:49AM -0600, Mark Langsdorf wrote:
>>> The function is buried pretty deep in the cpufreq_stat code. It didn't
>>> seem appropriate to make it a function pointer as part of struct
>>> cpufreq_driver.
>>
>> Better yet, add a flag or a bitfield called "minimize_jitter" or similar
>> and set it only on your hardware...
>
> Doing it in two passes has a similar effect: systems that have exact
> frequencies will get caught in the first pass when the values match. But
> adding a flag makes sense.

I went back and looked at implementing this suggestion.

Although cpufreq_driver has a flag field, no part of cpufreq_driver is directly passed to the cpufreq_stat code. Only cpufreq_policy is. It's cleaner to do passes of the while loop than to copy the cpufreq_driver.flag field into cpufreq_policy and then store it again in cpufreq_stats.

--Mark Langsdorf
Calxeda, Inc.