From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v8 2/4] power: reset: add reboot mode driver
Date: Sat, 18 Jun 2016 11:08:40 +0800
Message-ID: <5764BB38.10503@rock-chips.com>
References: <1461567051-21734-1-git-send-email-andy.yan@rock-chips.com>
 <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
 <20160616143616.GA11677@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160616143616.GA11677@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: robh+dt@kernel.org, heiko@sntech.de, k.kozlowski@samsung.com, john.stultz@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, alexandre.belloni@free-electrons.com, moritz.fischer@ettus.com, f.fainelli@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian:

On 2016=E5=B9=B406=E6=9C=8816=E6=97=A5 22:36, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Apr 25, 2016 at 02:55:36PM +0800, Andy Yan wrote:
>> This driver parses the reboot commands like "reboot bootloader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the write interfae to store the boot
>> mode in some place like special register or sram, which can
>> be read by the bootloader after system reboot, then the bootloader
>> can take different action according to the mode stored.
>>
>> This is commonly used on Android based devices, in order to
>> reboot the device into fastboot or recovery mode.
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Tested-by: John Stultz <john.stultz@linaro.org>
>> Acked-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> What's the status of this patchset? It still has a few open
> comments/issues, but I did not see a newer version.
>
> -- Sebastian

   Sorry for the delay, I will send a new version next week.
