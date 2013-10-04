From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 3/6] PowerCap: Added to drivers build
Date: Fri, 04 Oct 2013 12:38:18 -0700
Message-ID: <524F192A.7050908@linux.intel.com>
References: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1380904616-17519-4-git-send-email-srinivas.pandruvada@linux.intel.com> <201310041524.20634.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201310041524.20634.gheskett@wdtv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gene Heskett <gheskett@wdtv.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On 10/04/2013 12:24 PM, Gene Heskett wrote:
> On Friday 04 October 2013, Srinivas Pandruvada wrote:
>> Added changes to Makefile and Kconfig to include in driver build.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>> drivers/Kconfig  | 2 ++
>> drivers/Makefile | 1 +
>> 2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index aa43b91..969e987 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -166,4 +166,6 @@ source "drivers/reset/Kconfig"
>>
>> source "drivers/fmc/Kconfig"
>>
>> +source "drivers/powercap/Kconfig"
>> +
>> endmenu
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index ab93de8..34c1d55 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -152,3 +152,4 @@ obj-$(CONFIG_VME_BUS)		+= vme/
>> obj-$(CONFIG_IPACK_BUS)		+= ipack/
>> obj-$(CONFIG_NTB)		+= ntb/
>> obj-$(CONFIG_FMC)		+= fmc/
>> +obj-$(CONFIG_POWERCAP)		+= powercap/
> I would object to this whole premise if it is not under the absolute
> control of the users program. Linuxcnc for instance is intimately married
> to a parport whose status for writes is absolutely stable from write to
> write, and whose status may be in some cases, read at sub 20 u-second
> intervals.  Anything which would imped this, puts the operator of a 50+ ton
> piece of machinery's life in jeopardy because its status is not readable in
> as close to real time as possible as it may be required to initiate a stop
> from some alarm condition before it has moved far enough to injure, maim or
> kill. 50 thousandths of an inch in further movement while moving a 70 ton
> milling machines table at 150 inches a minute is not an unreasonable
> expectation for us.
<Sorry, I didn't understand. Are you pointing any problem in this patch 
or patch-set in general?
This change added powercap directory to the kernel build. Is something 
wrong with it or any other way to do that?
 >
> Cheers, Gene
