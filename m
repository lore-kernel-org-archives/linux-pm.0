From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Wed, 13 Jul 2016 16:20:06 -0700
Message-ID: <5786CCA6.2090709@gmail.com>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
 <1468394851.3638.13.camel@pengutronix.de> <20160713084250.GB11863@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36392 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcGMXUL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 19:20:11 -0400
In-Reply-To: <20160713084250.GB11863@shlinux2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org



On 07/13/2016 01:42 AM, Peter Chen wrote:
> On Wed, Jul 13, 2016 at 09:27:31AM +0200, Philipp Zabel wrote:
>> Am Mittwoch, den 13.07.2016, 10:06 +0800 schrieb Peter Chen:
>>> Add binding doc for generic power sequence library.
>>>
>>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>>> ---
>>>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>>> new file mode 100644
>>> index 0000000..186c58c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
>>> @@ -0,0 +1,53 @@
>>> +The generic power sequence library
>>> +
>>> +Some hard-wired USB/MMC devices need to do power sequence to let the
>>> +device work normally,
>> I would replace "to let the device work normally" with "before the
>> device can be enumerated [on the bus]" here.
>>
> Ok.
>
>>>  the typical power sequence like: enable USB
>>> +PHY clock, toggle reset pin, etc. But current Linux USB driver
>>> +lacks of such code to do it, it may cause some hard-wired USB devices
>>> +works abnormal or can't be recognized by controller at all. The
>>> +power sequence will be done before this device can be found at USB
>>> +bus.
>>> +
>>> +The power sequence properties is under the device node.
>>> +
>>> +Required properties:
>>> +- power-sequence: this device needs to do power sequence before enumeration
>> As Joshua pointed out, is this even needed at all?
>>
> If no, how we decide whether allocates pwrseq instance through pwrseq
> library or not?
>
The pwrseq driver is Linux specific. The dts is supposed to be OS agnostic.
It seems to me that If a driver supports pwrseq and the dts elements
are there, it should use them, e.g. if there is a clock, enable the clock.
if there is a reset gpio then take the device into and out of reset during probe.

Can you see a  problem with that approach?
