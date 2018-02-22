From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 19/20] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Thu, 22 Feb 2018 09:48:06 +0000
Message-ID: <1f04bbaf-83ae-6351-dbc9-82d27af030e1@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
 <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
 <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Klimov <klimov.linux@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, ALKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 22/02/18 09:04, Quentin Perret wrote:
> Hi Sudeep,
> 
> On Monday 12 Feb 2018 at 18:45:23 (+0000), Sudeep Holla wrote:
> [...]
>> +/*
>> + * perf_ops->freq_set is not a synchronous, the actual OPP change will
>> + * happen asynchronously and can get notified if the events are
>> + * subscribed for by the SCMI firmware
>> + */
>> +static int
>> +scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>> +{
>> +	struct scmi_data *priv = policy->driver_data;
>> +	struct scmi_perf_ops *perf_ops = handle->perf_ops;
>> +	u64 freq = policy->freq_table[index].frequency * 1000;
>> +
>> +	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
>> +}
> 
> Is arch_set_freq_scale() needed in this function ?
> 

Yes indeed, already added locally[1] after Dietmar started the discussion.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-list/new_arm_scmi
