From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: acpi_idle and max_cpus
Date: Mon, 18 Jun 2012 17:55:30 +0530
Message-ID: <4FDF1E3A.6010200@linux.vnet.ibm.com>
References: <4FDB549F.1020002@linaro.org> <4FDE3B96.8030306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDE3B96.8030306@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 06/18/2012 01:48 AM, Daniel Lezcano wrote:

> On 06/15/2012 05:28 PM, Daniel Lezcano wrote:
>>
>> Hi all,
>>
>> I have a dual core Intel T9500.
>>
>> I boot the cpu with the acpi_idle driver and intel_idle enabled in the
>> config.
>>
>> The kernel is booted with maxcpus=1.
>>
>> After the system has boot, I put cpu1 online via sysfs.
>>
>> But I don't see any 'cpuidle' directory in the cpu's sysfs entry:
>>
>> /sys/devices/system/cpu/cpu1/cpuidle (?)
>>
>> When I look at the code I see the notifier is present for hotplug in
>> processor_driver.c and the cpuidle intel init routine should be called
>> there.
>>


Yes, we have a hotplug notifier.
Commit 99b72508  by Thomas Renninger fixed this issue.

Please let me know which kernel version you are running and what is idle
driver registered ?

>> I am wondering is it a bug or an expected behavior ?
> 
> Any thoughts on that ?
> 
> Thanks
>   -- Daniel
> 
> 


Cheers
Deepthi
