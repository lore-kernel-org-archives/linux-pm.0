From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v6 00/11] qcom: Add support for TSENS driver
Date: Thu, 30 Jun 2016 09:55:04 +0530
Message-ID: <57749F20.4010700@codeaurora.org>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
 <575A57F8.6060004@codeaurora.org> <576391B3.7090508@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <576391B3.7090508@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: edubezval@gmail.com, andy.gross@linaro.org, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, punit.agrawal@arm.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

Rui,

On 06/17/2016 11:29 AM, Nayak, Rajendra wrote:
> Hey Eduardo,
> 
> On 6/10/2016 11:32 AM, Rajendra Nayak wrote:
>> Eduardo,
>>
>> On 05/05/2016 02:21 PM, Rajendra Nayak wrote:
>>> Current set of patches apply on 4.6-rc6. Fixes for the nvmem apis
>>> are now posted [1] and queued in -next [2]
>>> Patches [1-6] will need to be merged via thermal tree/Eduardo.
>>
>> Any plans to pull these in for 4.8?
> 
> These patches have been on the list for quite a while, and they
> do not have any outstanding dependencies or comments to be
> addressed. I would really hope to see these in for 4.8.
> Let me know if there is something you want me to address before
> you pull them in.

Would you be able to pull this driver in? I haven't heard back
anything from Eduardo despite multiple pings.
These patches (v6) have been on the list for a couple months now,
which address all issues/concerns that were raised by Eduardo
in his previous reviews.

regards,
Rajendra

> 
> regards,
> Rajendra
> 
>>
>> regards,
>> Rajendra
>>
>>> Patches [7-11] will need to go via qcom-msm tree/Andy.
>>>
>>> Changes since v5:
>>> * Minor review fixes from Eduardo
>>>
>>> Changes since v4:
>>> * dropped qcom,tsens-slopes binding, used coefficients instead
>>> * dropped qcom,sensor-id binding
>>> * Added support for msm8996 family
>>> * Other minor review fixes from v4
>>>
>>> Changes since v3:
>>> * Dropped 'clk: qcom: create virtual child device for TSENS' which
>>> is picked up by Stephen
>>> * Updated GCC bindings with optional TSENS properties
>>>
>>> Changes since v2:
>>> * Minor review fixes from Stephen/Punit and rebase on 4.3-rc4
>>>
>>> Changes since v1:
>>> * Created virtual tsens device from gcc driver for 8960,
>>> with DT having a single node for gcc and tsens
>>> * Minor fixes with rebasing on 4.3-rc1
>>>
>>> Changes since RFC:
>>> * Added support for 8916 and 8084
>>> * Based off the latest nvmem framework patches [1]
>>> * Minor review fixes for comments mostly from Lina
>>>
>>> This is an attempt to have a single TSENS driver for
>>> the different versions of the TSENS IP that exist, on
>>> different qcom msm/apq SoCs'
>>> Support is added for msm8916, msm8960, msm8974 and msm8996 families.
>>>
>>> A lot of the work is based of original code from Stephen Boyd
>>> and Siddartha Mohanadoss. I have also picked some of what
>>> Narendran Rajan did in his attempt to upstream the support
>>> for 8960 family. I could not keep the original authorship on
>>> any of the patches because I ended up moving the code around
>>> quite a bit in an effort to have a single driver for the
>>> various devices. I would be glad to change the authorship
>>> for any of the patches if needed.
>>>
>>> [1] https://lkml.org/lkml/2016/4/24/103
>>> [2] git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next
>>>
>>> Rajendra Nayak (11):
>>>    thermal: qcom: tsens: Add a skeletal TSENS drivers
>>>    thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
>>>    thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
>>>    thermal: core: export apis to get slope and offset
>>>    thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
>>>    thermal: qcom: tsens-8996: Add support for 8996 family of SoCs
>>>    arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
>>>    arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
>>>    arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes
>>>    arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes
>>>    arm64: dts: msm8996: Add thermal zones, tsens and qfprom nodes
>>>
>>>   .../devicetree/bindings/clock/qcom,gcc.txt         |  18 ++
>>>   .../devicetree/bindings/thermal/qcom-tsens.txt     |  21 ++
>>>   Documentation/thermal/sysfs-api.txt                |  12 +
>>>   arch/arm/boot/dts/qcom-apq8064.dtsi                | 103 ++++++++
>>>   arch/arm/boot/dts/qcom-apq8084.dtsi                | 103 ++++++++
>>>   arch/arm/boot/dts/qcom-msm8974.dtsi                | 103 ++++++++
>>>   arch/arm64/boot/dts/qcom/msm8916.dtsi              |  64 +++++
>>>   arch/arm64/boot/dts/qcom/msm8996.dtsi              |  92 +++++++
>>>   drivers/thermal/Kconfig                            |   5 +
>>>   drivers/thermal/Makefile                           |   1 +
>>>   drivers/thermal/qcom/Kconfig                       |  11 +
>>>   drivers/thermal/qcom/Makefile                      |   2 +
>>>   drivers/thermal/qcom/tsens-8916.c                  | 113 ++++++++
>>>   drivers/thermal/qcom/tsens-8960.c                  | 292 +++++++++++++++++++++
>>>   drivers/thermal/qcom/tsens-8974.c                  | 244 +++++++++++++++++
>>>   drivers/thermal/qcom/tsens-8996.c                  |  84 ++++++
>>>   drivers/thermal/qcom/tsens-common.c                | 141 ++++++++++
>>>   drivers/thermal/qcom/tsens.c                       | 200 ++++++++++++++
>>>   drivers/thermal/qcom/tsens.h                       |  92 +++++++
>>>   drivers/thermal/thermal_core.c                     |  30 +++
>>>   include/linux/thermal.h                            |   8 +
>>>   21 files changed, 1739 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>>>   create mode 100644 drivers/thermal/qcom/Kconfig
>>>   create mode 100644 drivers/thermal/qcom/Makefile
>>>   create mode 100644 drivers/thermal/qcom/tsens-8916.c
>>>   create mode 100644 drivers/thermal/qcom/tsens-8960.c
>>>   create mode 100644 drivers/thermal/qcom/tsens-8974.c
>>>   create mode 100644 drivers/thermal/qcom/tsens-8996.c
>>>   create mode 100644 drivers/thermal/qcom/tsens-common.c
>>>   create mode 100644 drivers/thermal/qcom/tsens.c
>>>   create mode 100644 drivers/thermal/qcom/tsens.h
>>>
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
