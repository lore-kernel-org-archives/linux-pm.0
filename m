From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Thu, 10 Sep 2015 11:42:37 -0500
Message-ID: <55F1B2FD.4020608@ti.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <D854C92F57B1B347B57E531E78D05EAD57904B8D@BGSMSX104.gar.corp.intel.com>
 <55F0C522.6070705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55F0C522.6070705@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org

On 09/09/2015 06:47 PM, Krzysztof Kozlowski wrote:
>>>> +- ti,enable-user-write: boolean, if present driver will allow the user space
>>>> +    to control the charging current and voltage through sysfs;
>>>
>>> This is not DT property. It does not describe hardware.
>> We needed a mechanism to enable the sysfs writes on certain properties.
>> If DT is not the place where should it go?
>
> DT is not the place. As I discussed later with Andreas, if you really
> need this and if mainline is a place for that then probably this should
> be compile option (a Kconfig symbol).
>

I think this would actually be a good use for module parameters, this way
it could still be set at boot without re-compiling.

I think compile-time disabling sysfs properties because they are "dangerous" is
a little bit too artificially restricting and controlling, you can set permissions
so only root can change them already. The kernel should not be restricting root,
I understand the fear of someone rooting a machine and remotely over charging
a LiPo[1], but these physical limits are hardware descriptions and can and should
be set by DT, beyond this root should have full control over their machine.
Besides root can already just unbind your driver and issue raw I2C commands to do
the same thing. </rant>

[1] http://i.imgur.com/vszJJ.jpg

Regards,
Andrew
