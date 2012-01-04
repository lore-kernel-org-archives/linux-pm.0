From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Re: [lm-sensors] [RFC PATCH 2/3] thermal: exynos4:
 Register the tmu sensor with the thermal interface layer
Date: Wed, 4 Jan 2012 10:23:35 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5901B976@BGSMSX101.gar.corp.intel.com>
References: <1324468798-20423-1-git-send-email-amit.kachhap@linaro.org>
	<1324468798-20423-3-git-send-email-amit.kachhap@linaro.org>
	<1325629553.26706.11.camel@groeck-laptop>
	<CAK44p20XeLVkJyox2SsDqyy=RYgEQNpyGGypwTMPXpueQT1T3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK44p20XeLVkJyox2SsDqyy=RYgEQNpyGGypwTMPXpueQT1T3g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Kachhap <amit.kachhap@linaro.org>, "guenter.roeck@ericsson.com" <guenter.roeck@ericsson.com>, Donggeun Kim <dg77.kim@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit Daniel,

> Hi Guenter,
> 
> The main idea of this work is to leave the current userspace based
> notification scheme and add the kernel based cooling scheme on top of
> it. Anyway, It is a good idea to move the file hwmon/exynos4_tmu.c as

But, What I feel is, kernel based cooling scheme will work only for
Controlling 'CPU' frequency. But in SoC's there are other devices that
Contribute to Thermal. For example, GPU, Display, Battery (during charging)
etc.. In this case, we need a user space to control these devices. So, in a
way, the user space notification mechanism is a unified solution for
throttling all devices and keeps the kernel code light weight.

I am also curious to know why the existing mechanism did not work for you ?

Thanks,
Durga

> this creates 2 hwmon entries.
> Adding CC: Donggeun Kim to know his opinion.
> 
> Thanks,
> Amit Daniel
[snip.]
