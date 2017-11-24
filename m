From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Add "cpuidle.use_deepest" to bypass governor and allow HW to go deep
Date: Fri, 24 Nov 2017 09:34:18 -0800
Message-ID: <000901d3654a$76411b80$62c35280$@net>
References: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com> FMlqe98CNhCDuFMlsezUVk
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: FMlqe98CNhCDuFMlsezUVk
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Len Brown' <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 2017.11.16 08:11 Thomas Ilsche wrote:
> On 2017-11-09 08:38, Len Brown wrote:
>> From: Len Brown <len.brown@intel.com>
>> 
>> While there are several mechanisms (cmdline, sysfs, PM_QOS) to limit
>> cpuidle to shallow idle states, there is no simple mechanism
>> to give the hardware permission to enter the deeptest state permitted by PM_QOS.
>> 
>> Here we create the "cpuidle.use_deepest" modparam to provide this capability.
>> 
>> "cpuidle.use_deepest=Y" can be set at boot-time, and
>> /sys/module/cpuidle/use_deepest can be modified (with Y/N) at run-time.
>
> This is a good option to have and can conveniently prevent idle power consumption
> issues. But that wouldn't be a reasonable default, would it?
> I still think there is an inherent need for a heuristic and a corresponding
> mitigation to avoid staying in a sleep state too long.

I think so, yes. The potential energy savings, depending on work flow, are significant.
For the idle state 0 case, I have some supporting data that I will send on
the other e-mail thread.

... Doug
