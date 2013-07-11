From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Thu, 11 Jul 2013 19:54:36 +0530
Message-ID: <51DEC024.50603@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de>	<8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com>	<51D06556.7080204@gmx.de> <51D07E7F.2030709@linux.vnet.ibm.com>	<51DDC8FA.4020609@gmx.de> <51DDE067.2020106@linux.vnet.ibm.com> <CAOLK0pwr03reaMWAEeaUs-6H2URoisFEJ3J4r83Rm1eTs1hU5w@mail.gmail.com> <51DE4F44.6060506@linux.vnet.ibm.com> <CAOLK0pyJ=MoE20adyg8oUP-bTiwvXobRNX4ayA5eGRH0UGbpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOLK0pyJ=MoE20adyg8oUP-bTiwvXobRNX4ayA5eGRH0UGbpgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, tianyu.lan@intel.com
List-Id: linux-pm@vger.kernel.org

On 07/11/2013 07:33 PM, Lan Tianyu wrote:
> 2013/7/11 Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>:
 
>> I tried to address all these in this patch, but you found yet another serious
>> loop-hole. I guess I'm out of ideas now... if anybody has any thoughts on how
>> to get this right, then I'm all ears. Else, we'll just revert the original
>> commit like Rafael suggested and leave it upto userspace to save and restore
>> the permissions across suspend/resume if it wants ;-(
>>
> 
> How about implement scaling driver's suspend/resume callback()? Although this
> needs to be dealt with case by case. If one's callbacks hasn't been implemented,
> it would have to follow current rule.
> 

Well, I'm now trying a slightly different approach at reorganizing the code,
and so far I think I'll be able to get it right this time. Let's see how it goes.

Regards,
Srivatsa S. Bhat
