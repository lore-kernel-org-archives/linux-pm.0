From: skannan@codeaurora.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Fri, 03 Aug 2018 12:52:48 -0700
Message-ID: <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@google.com>
Cc: tdas@codeaurora.org, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, anischal@codeaurora.org, devicetree@vger.kernel.org, robh@kernel.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-03 12:40, Evan Green wrote:
> Hi Taniya,
> 
> On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>> 
>> The CPUfreq HW present in some QCOM chipsets offloads the steps 
>> necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm       |  11 ++
>>  drivers/cpufreq/Makefile          |   1 +
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 
>> ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 360 insertions(+)
>>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>> 
> ...
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..ea8f7d1
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> ...
>> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>> +                                   struct cpufreq_qcom *c)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, 
>> cur_freq;
>> +
>> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +                               sizeof(*c->table), GFP_KERNEL);
>> +       if (!c->table)
>> +               return -ENOMEM;
>> +
>> +       base = c->reg_bases[REG_LUT_TABLE];
>> +
>> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +               data = readl_relaxed(base + i * LUT_ROW_SIZE);
>> +               src = (data & GENMASK(31, 30)) >> 30;
>> +               lval = data & GENMASK(7, 0);
>> +               core_count = CORE_COUNT_VAL(data);
>> +
>> +               if (src)
>> +                       c->table[i].frequency = c->xo_rate * lval / 
>> 1000;
>> +               else
>> +                       c->table[i].frequency = INIT_RATE / 1000;
> 
> I don't know much about how this hardware works, but based on the
> mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
> and 3 all mean xo_rate?
> 
> Also, is INIT_RATE really constant? It sounds like gpll0 (or
> gpll0_out_even?). You're already getting the xo clock, why not get
> gpll0's real rate as well?

Actually I was about to comment and say NOT to get clocks just to get 
their rate. The XO_RATE is just a multiplication factor. This HW/FW can 
change in the future and make the multiplication factor to 1KHz. We also 
can't really control any of the clocks going to this block from Linux 
(it's all locked down). Adding clk_get significantly delays when this 
driver can be probed and increases boot up time. The INIT_RATE will 
always be 300 MHz independent of what source it's coming from (as in, if 
GPLL0 can't give 300, the HW design will be so that we'll find a 
different source).

So, I'd like to remove any clock bindings for this driver.

Thanks,
Saravana
