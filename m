From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 09/13] thermal: qoriq: Convert driver to use regmap API
Date: Thu, 11 Apr 2019 15:00:51 +0200
Message-ID: <dac3e90a-dd9f-56eb-faa2-c48d1fe380da@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-10-andrew.smirnov@gmail.com>
 <52c33c26-47fa-04d2-0808-65a53fd2c804@linaro.org>
 <CAHQ1cqGbBXdQBagcKH211N0GkBzQzsutbu6=FMLLxZoL8pL8bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqGbBXdQBagcKH211N0GkBzQzsutbu6=FMLLxZoL8pL8bA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/04/2019 20:24, Andrey Smirnov wrote:

[ ... ]

>>> +static const struct regmap_range qiriq_yes_ranges[] = {
>>> +     regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>>> +     regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
>>> +     /* Read only registers below */
>>> +     regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
>>> +};
>>> +
>>> +static const struct regmap_access_table qiriq_wr_table = {
>>> +     .yes_ranges     = qiriq_yes_ranges,
>>> +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges) - 1,
>>> +};
>>> +
>>> +static const struct regmap_access_table qiriq_rd_table = {
>>> +     .yes_ranges     = qiriq_yes_ranges,
>>> +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges),
>>> +};
>>
>> As the table are the same, it would make sense to fold both structure to
>> a single one (and s/qiriq/qoriq/ ?)
>>
> 
> Writable registers are a subset of readable registers and n_yes_ranges
> is different between the two. Not sure how I could fold the two into a
> single struct.

Right, never mind my comment.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
