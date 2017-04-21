From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Fri, 21 Apr 2017 18:37:31 -0300
Message-ID: <CAOMZO5C776E3AqnhPPJSTF=atuOHi5Mok7F7yocBhRsJ6Ror2A@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <1998934.0RuxqCUAOW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1998934.0RuxqCUAOW@aspire.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 21, 2017 at 6:28 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, April 21, 2017 01:11:52 PM Fabio Estevam wrote:
>> Hi,
>>
>> Running 4.11-rc7 on a imx6q-sabresd board I notice that egalax
>> touchscreen stops generating evtest events after a random period of
>> time.
>>
>> This problem can be avoided if I unselect CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND:
>>
>> --- a/arch/arm/configs/imx_v6_v7_defconfig
>> +++ b/arch/arm/configs/imx_v6_v7_defconfig
>> @@ -54,7 +54,6 @@ CONFIG_CMA=y
>>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>>  CONFIG_KEXEC=y
>>  CONFIG_CPU_FREQ=y
>> -CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>>  CONFIG_ARM_IMX6Q_CPUFREQ=y
>>  CONFIG_CPU_IDLE=y
>>  CONFIG_VFP=y
>>
>> With this change evtest always capture all touchscreen events. No
>> single failure is seen.
>>
>> I could see the same behavior with all mainline kernels I tested (4.9 and 4.10).
>>
>> Any ideas as to how fix this bug when CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y?
>
> And which governor is the default otherwise?

When CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y is removed then the
'performance' governor is the default.

Thanks
