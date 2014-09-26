From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH v6 0/4] Tegra124 soctherm driver
Date: Fri, 26 Sep 2014 13:22:52 +0300
Message-ID: <54253E7C.9080704@kapsi.fi>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi> <20140926101918.GM31106@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140926101918.GM31106@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <cyndis@kapsi.fi>
Cc: edubezval@gmail.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, juha-matti.tilli@iki.fi
List-Id: linux-pm@vger.kernel.org

On 09/26/2014 01:19 PM, Thierry Reding wrote:
> On Fri, Sep 26, 2014 at 12:43:09PM +0300, Mikko Perttunen wrote:
>> Hi,
>>
>> this series adds support for the thermal monitoring features of the
>> soctherm unit on the Tegra124 SoC.
>>
>> The branch is also available in my github repo,
>>    git://github.com/cyndis/linux.git soctherm-v6
>>
>> Thanks,
>> Mikko
>>
>> Mikko Perttunen (4):
>>    of: Add bindings for nvidia,tegra124-soctherm
>>    ARM: tegra: Add soctherm and thermal zones to Tegra124 device tree
>>    ARM: tegra: Add thermal trip points for Jetson TK1
>>    thermal: Add Tegra SOCTHERM thermal management driver
>>
>>   .../devicetree/bindings/thermal/tegra-soctherm.txt |  53 +++
>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  44 ++
>>   arch/arm/boot/dts/tegra124.dtsi                    |  47 ++
>>   drivers/thermal/Kconfig                            |  10 +
>>   drivers/thermal/Makefile                           |   1 +
>>   drivers/thermal/tegra_soctherm.c                   | 471 +++++++++++++++++++++
>>   include/dt-bindings/thermal/tegra124-soctherm.h    |  13 +
>>   7 files changed, 639 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
>>   create mode 100644 drivers/thermal/tegra_soctherm.c
>>   create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h
>
> One thing that I've wanted to start doing for a while now is request
> patch submissions like this to come accompanied with a way on how to
> test them. Ideally this would be in a scripted way that can test for
> success programatically, but it doesn't necessarily have to be if it
> turns out too difficult or impractical to do.

Indeed, that would be very useful.

>
> The goal is to eventually come up with a test suite that can run the
> majority of test cases automatically to make it easy to test for any
> regressions. And even if tests can't be run automatically it'd still
> be an advantage to have them all collected in some repository, since
> it saves a lot of typing and time to run tests, and it will give us
> a standard set of tests that everybody can verify changes against.
>
> I realize that it's somewhat unfair to start requesting this from you
> now, but we've got to start somewhere. Could you give a short summary
> of how you test this? What are the interfaces that the kernel exposes
> for these thermal drivers?

You need to enable the driver in Device Drivers -> Generic Thermal sysfs 
driver -> Tegra SOCTHERM thermal management. Then, you should see 
directories appear in /sys/class/thermal. You can also use the `tmon' 
tool included in the kernel tree to quickly see values; that's what I 
use for testing.

>
> Thierry
>

Mikko
