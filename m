From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
Date: Mon, 1 Apr 2019 09:18:19 +0200
Message-ID: <86b89b19-73fe-4ec9-d030-a72f191a44d1@linaro.org>
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
 <CABXOdTeB+5vNi+mRBf2ff2YJG5WVRAGFjBz-ehjDTCyQdcpr7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXOdTeB+5vNi+mRBf2ff2YJG5WVRAGFjBz-ehjDTCyQdcpr7A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, Daniel Mack <daniel@zonque.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:MIPS" <linux-mips@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Guenter,

thanks for the review.

On 01/04/2019 06:10, Guenter Roeck wrote:
> On Sun, Mar 31, 2019 at 8:24 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The module support for the thermal subsystem does have a little sense:
> 
> Do you mean "makes little sense" ?

yep :)

>>  - some subsystems relying on it are not modules, thus forcing the
>>    framework to be compiled in
>>  - it is compiled in for almost every configs, the remaining ones
>>    are a few platforms where I don't see why we can not switch the thermal
>>    to 'y'. The drivers can stay in tristate.
>>  - platforms need the thermal to be ready as soon as possible at boot time
>>    in order to mitigate
>>
>> Usually the subsystems framework are compiled-in and the plugs are as module.
>>
>> Remove the module option. The removal of the module related dead code will
>> come after this patch gets in or is acked.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Sounds like a good idea.
> 
> Acked-by: Guenter Roeck <groeck@chromium.org>
> 
> Many dependencies such as the following can probably be simplified or
> removed after this patch has been accepted.
> 
> depends on THERMAL=y
> depends on THERMAL || THERMAL=n
> depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
> depends on !(MLXSW_CORE=y && THERMAL=m)
> depends on THERMAL || !THERMAL
> depends on HWMON=y || HWMON=THERMAL
> depends on THERMAL || !THERMAL_OF

Absolutely.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
