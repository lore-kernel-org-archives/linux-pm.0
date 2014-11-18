From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 18 Nov 2014 12:28:24 -0800
Message-ID: <546BABE8.2030406@codeaurora.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org> <1414194024-55547-3-git-send-email-lina.iyer@linaro.org> <20141114224620.GD11808@codeaurora.org> <20141118165614.GB770@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141118165614.GB770@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/18/2014 08:56 AM, Lina Iyer wrote:
> On Fri, Nov 14 2014 at 15:46 -0700, Stephen Boyd wrote:
>> On 10/24, Lina Iyer wrote:
>
>>> +{
>>> +    struct spm_driver_data *drv = this_cpu_ptr(&cpu_spm_drv);
>>> +    u32 start_index;
>>> +    u32 ctl_val;
>>> +
>>> +    if (!drv->available)
>>> +        return -ENXIO;
>>
>> It would be nice if we didn't need this by only registering the
>> cpuidle device for this CPU once we've initialized the SPM
>> hardware.
>>
> I did explore it. It strays our cpuidle code away from the standard code
> that we are trying to go towards with idle-states framework.
>
>

So fix the framework?

>>> +
>>> +    /* Write the SPM sequences, first.. */
>>> +    addr = drv->reg_base +
>>> drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>> +    seq_data = (const u32 *)drv->reg_data->seq;
>>
>> Why do we need a cast?
>>
> Compiler warns otherwise.
>
>

How?

$ cat main.c
extern int magic(const void *d);

struct m {
        unsigned int data[2];
};

struct s {
        const struct m *m;
};

static const struct m m = {
        .data = { 0x345, 0x34},
};

static const struct s s = {
        .m = &m,
};

int main()
{
        const unsigned int *d;
        d = s.m->data;
        return magic(d);
}

$ gcc -c main.c

>
>>> +        .of_match_table = spm_match_table,
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(spm_driver);
>>
>> MODULE_LICENSE()?
>> MODULE_ALIAS()?
>>
> MODULE_DESCRIPTION() would work?
>

Sure, add them all please.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
