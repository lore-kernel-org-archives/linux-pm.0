From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle/powernv : Add Description for cpuidle state
Date: Tue, 29 May 2018 22:30:57 +1000
Message-ID: <87sh6a4pa6.fsf@concordia.ellerman.id.au>
References: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com> <87d0xf6y16.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d0xf6y16.fsf@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stewart Smith <stewart@linux.ibm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, benh@kernel.crashing.org, paulus@samba.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Stewart Smith <stewart@linux.ibm.com> writes:

> Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:
>> @@ -215,7 +216,7 @@ static inline void add_powernv_state(int index, const char *name,
>>  				     u64 psscr_val, u64 psscr_mask)
>>  {
>>  	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
>> -	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
>> +	strlcpy(powernv_states[index].desc, desc, CPUIDLE_DESC_LEN);
>
> We should still fall back to using name in the event of desc being null,
> as not all firmware will expose the descriptions.
>
>> @@ -311,6 +313,11 @@ static int powernv_add_idle_states(void)
>>  		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
>>  		goto out;
>>  	}
>> +	if (of_property_read_string_array(power_mgt,
>> +		"ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
>> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n");
>> +		goto out;
>> +	}
>
> I don't think pr_warn is appropriate here, as for all current released
> firmware we don't have that property. I think perhaps just silently
> continuing on is okay, as we have to keep compatibility with that firmware.

+1

Anyone who's wondering why they're not seeing the names can just look at
the device tree on the machine to see if the property is there or not,
they don't need a printk in dmesg to tell them.

cheers
