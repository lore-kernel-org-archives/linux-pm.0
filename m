From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] APM idle: register apm_cpu_idle via cpuidle
Date: Wed, 20 Feb 2013 12:48:33 -0500
Message-ID: <51250C71.6080109@kernel.org>
References: <5118B776.6090604@linaro.org> <1360623789-12247-1-git-send-email-lenb@kernel.org> <17242de27db147c4f828d6089016e1f485c038fb.1360623445.git.len.brown@intel.com> <alpine.LNX.2.00.1302181429570.17024@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1302181429570.17024@pobox.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 02/18/2013 08:30 AM, Jiri Kosina wrote:
> On Mon, 11 Feb 2013, Len Brown wrote:
> 
>> From: Len Brown <len.brown@intel.com>
>>
>> Update APM to register its local idle routine with cpuidle.
>>
>> This allows us to stop exporting pm_idle to modules on x86.
>>
>> The Kconfig sub-option, APM_CPU_IDLE, now depends on on CPU_IDLE.
>>
>> Compile-tested only.
> 
> I will test it on APM hardware and report back to you.
> 
> Do you then want me to take it through my tree, or are you going to push 
> the whole patchset as a whole?

Rafael took my series as a whole into his PM tree
and it is currently staged for a 3.9 pull.
But if I broke your APM box, I'm standing by
ready to fix it during the release.

Please get back to me with the test results:

dmesg | grep idle
grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*

would tell us if it is working or not.

thanks!
-Len Brown, Intel Open Source Technology Center


