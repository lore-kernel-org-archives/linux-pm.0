From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 0122/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 19:05:48 +0200
Message-ID: <335df7ab-6663-b14a-de33-7a485489c20e@suse.cz>
References: <Pine.LNX.4.44L0.1608020955530.1940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1608020955530.1940-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Baole Ni <baolex.ni@intel.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

On 08/02/2016, 03:57 PM, Alan Stern wrote:
>> --- a/drivers/cpufreq/powernow-k7.c
>> +++ b/drivers/cpufreq/powernow-k7.c
>> @@ -683,7 +683,7 @@ static void __exit powernow_exit(void)
>>  	cpufreq_unregister_driver(&powernow_driver);
>>  }
>>  
>> -module_param(acpi_force,  int, 0444);
>> +module_param(acpi_force,  int, S_IRUSR | S_IRGRP | S_IROTH);
> 
> This is an excellent example.  To me, 0444 is _much_ more readable and 
> understandable than S_IRUSR | S_IRGRP | S_IROTH.

If anything, that should be S_IRUGO. However, I personally prefer
numbers over macros too.

thanks,
-- 
js
suse labs
