From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v4 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Thu, 1 Sep 2016 17:37:28 +0800
Message-ID: <189f3a28-bef7-674e-de7e-f987b83026d0@electromag.com.au>
References: <1bIiDr-0004G1-0P>
 <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
 <1472156461-25180-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160831144349.GA18510@rob-hp-laptop>
 <4d255da80e88b400bc6f481b7fa48403@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:39195 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751873AbcIAJho (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 05:37:44 -0400
In-Reply-To: <4d255da80e88b400bc6f481b7fa48403@schneider-inet.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: karl-heinz@schneider-inet.de, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>

Sorry for the resend, I noticed my reply also got horrible mangled.

On 1/09/2016 06:34, Karl-Heinz Schneider wrote:
> Hi Rob,
>
> Sorry for resending this mail, evolution mixed it up...
>
> On Wed, 31 Aug 2016 09:43:49 -0500, Rob Herring wrote:
>> On Thu, Aug 25, 2016 at 10:21:00PM +0200, Karl-Heinz Schneider wrote:
>>> This patch adds device tree documentation for the sbs-manager
>>>
>>> Reviewed-by: Phil Reid <preid@electromag.com.au>
>>> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
>>> ---
>>>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 53 ++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>> new file mode 100644
>>> index 0000000..6b1a87ce
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>> @@ -0,0 +1,53 @@
>>> +Binding for sbs-manager
>>> +
>>> +Required properties:
>>> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallback.
>>> +- reg: integer, i2c address of the device. Should be <0xa>.
>>
>> What happened to adding Phil's interrupt support into this? You don't
>> have to add the whole patch, just the binding part. The driver support
>> can come later.
>
> Phil revoked his patch. Right now it's not clear how the interrupt/gpio
> solution will look like and if they will need an device tree binding at
> all...
>


I'm getting back to this now.
I think we can use the smbalert driver to handle the source interrupt.
Which I think doesn't need anything in the dt binding. Driver just needs to
implement the alert callback.
I haven't figured out if the smb_alert could be used for the sbs-battery
driver interrupt or if this would make sense. However I think it would still need
to be a gpio controller in either case so that it can report the presence of the
batteries in a manner suitable for the sbs-battery driver to use.
I think the gpio controller approach is the simpler method.
It looks like the smbalert_driver driver needs some updates to work with device trees.
I need a bit more time to investigate this option.

-- 
Regards
Phil Reid

