From: Alexandre Bailon <abailon@baylibre.com>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Fri, 15 Mar 2019 17:55:10 +0100
Message-ID: <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Patrick Titiano <ptitiano@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Emilio Lopez <emilio@elopez.com.ar>, Hans de Goede <hdegoede@redhat.com>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zening Wang <zening.wang@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Mike,
On 3/15/19 5:17 PM, Michael Turquette wrote:
> Hi Alex,
> 
> Some nitpick review comments below.
> 
> On Wed, Mar 13, 2019 at 12:33 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>>
>> This series implements busfreq, a framework used in MXP's
> 
> s/MXP/NXP/
> 
>> tree to scale the interconnect and dram frequencies.
>> In the vendor tree, device's driver request for a
>> performance level, which is used to scale the frequencies.
>> This series implements it using the interconnect framework.
>> Devices' driver request for bandwidth which is use by busfreq
>> to determine a performance level, and then scale the frequency.
>>
>> Busfreq is quite generic. It could be used for any i.MX SoC.
>> A busfreq platform driver just have to define a list of
>> interconnect nodes, and some OPPs.
>>
>> This series is sent as RFC mostly because the current support
>> of i.MX SoC won't benefit of busfreq framework, because the
>> clocks' driver don't support interconnect / dram frequency
>> scaling.
> 
> In your v2 cover letter could you post a link to a git branch that has
> everything integrated that is needed to test the series? I guess this
> is similar to what Aisheng asked for already.
I will do it.
> 
>> As exemple, this series implements busfreq for i.MX8MM whose
>> upstreaming is in progress. Because this relies on ATF to
>> do the frequency scaling, it won't be hard make it work.
> 
> It's not clear to me whether this series actual scales the dram
> frequency based on what you said above. Is it just theoretical or do
> you have it working with a pile of out-of-tree patches? Would be good
> to include that pile of patches in your integration branch that I
> suggested above.
The current series only introduce busfreq generic driver, and the 
busfreq driver for the imx8mm.
As is, the imx8mm driver will just be loaded, but do nothing because
none of the drivers have been updated to request bandwidth using the 
interconnect framework.
In addition, the current clock driver of imx8mm doesn't allow dram 
frequency scaling, so if busfreq driver tries, it will fail (should be 
harmless because any other clocks should restored to their previous rate).

My intent was to sent a first draft o busfreq, to get some feedback, 
before to send a more complete, and fully functional series.

Thanks,
Alexandre
> 
> Thanks,
> Mike
> 
>>
>> As exemple, this series implements busfreq for
>> Alexandre Bailon (3):
>>    drivers: interconnect: Add a driver for i.MX SoC
>>    drivers: interconnect: imx: Add support of i.MX8MM
>>    dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
>>
>>   .../bindings/interconnect/imx8mm.txt          |  24 +
>>   drivers/interconnect/Kconfig                  |   1 +
>>   drivers/interconnect/Makefile                 |   1 +
>>   drivers/interconnect/imx/Kconfig              |  17 +
>>   drivers/interconnect/imx/Makefile             |   2 +
>>   drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
>>   drivers/interconnect/imx/busfreq.c            | 570 ++++++++++++++++++
>>   drivers/interconnect/imx/busfreq.h            | 123 ++++
>>   include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>>   9 files changed, 907 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt
>>   create mode 100644 drivers/interconnect/imx/Kconfig
>>   create mode 100644 drivers/interconnect/imx/Makefile
>>   create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.h
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>>
>> --
>> 2.19.2
> 
> 
> 
