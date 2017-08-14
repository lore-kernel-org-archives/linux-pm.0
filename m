From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 0/4] add support of SCPSYS power domain for MediaTek
 MT7622
Date: Mon, 14 Aug 2017 17:30:21 +0200
Message-ID: <2a112b79-20a0-e09d-28a9-24b412d20874@gmail.com>
References: <cover.1502090240.git.sean.wang@mediatek.com>
 <CAPDyKFpDyhPc=T8SqWdh-mm4kOqFstHNMuRbL_qP04rynoLcsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpDyhPc=T8SqWdh-mm4kOqFstHNMuRbL_qP04rynoLcsw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mediatek@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 08/08/2017 01:41 PM, Ulf Hansson wrote:
> On 7 August 2017 at 09:24,  <sean.wang@mediatek.com> wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Changes since v2:
>> - reduce code duplication of scpsys_probe across all SoCs
>>
>> Changes since v1:
>> - rebase to Linux v4.13-rc1
>>
>> There are four power domains on MediaTek MT7622 SoC which are respectively
>> ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
>> SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.
>>
>> Those functions could be selectively powered gated when the corresponding
>> function is no longer to use in order to reach more minimal power
>> dissipation through the patch series introduced here.
>>
>> Chen Zhong (1):
>>    soc: mediatek: add header files required for MT7622 SCPSYS dt-binding
>>
>> Sean Wang (3):
>>    dt-bindings: soc: update the binding document for SCPSYS on MediaTek
>>      MT7622 SoC
>>    soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
>>    soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC
>>
>>   .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
>>   drivers/soc/mediatek/mtk-scpsys.c                  | 247 ++++++++++++---------
>>   include/dt-bindings/power/mt7622-power.h           |  22 ++
>>   include/linux/soc/mediatek/infracfg.h              |   7 +
>>   4 files changed, 179 insertions(+), 100 deletions(-)
>>   create mode 100644 include/dt-bindings/power/mt7622-power.h
>>
>> --
>> 2.7.4
>>
> 
> Looks good to me! Feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

Pushed to v4.13-next/soc with the Reviewed-by.

Thanks!
