From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/7] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Wed, 22 Mar 2017 16:57:52 +0100
Message-ID: <425d544f-bce5-0f4d-62d1-1926e5ad9471@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-4-hdegoede@redhat.com>
 <20170322155029.GX8575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760473AbdCVP6A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:58:00 -0400
In-Reply-To: <20170322155029.GX8575@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 22-03-17 16:50, Tony Lindgren wrote:
> * Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
>> Add support for monitoring an extcon device with USB SDP/CDP/DCP and HOST
>> cables and adjust ilimit and enable/disable the 5V boost converter
>> accordingly. This is necessary on systems where the PSEL pin is hardwired
>> high and ILIM needs to be set by software based on the detected charger
>> type, as well as on systems where the 5V boost converter is used, as
>> that always needs to be enabled from software.
>
> I wonder if these cross device and cross subsystem events really should
> be handled at the framework level? Otherwise the permutations get out
> of control fast..

There are a lot of hw specific things in here which are hard to generalize,
like not only setting iilim but also enabling the booster when there
is no charger and we are in host mode (the no charger condition is
necessary for USB ACAs).

Regards,

Hans
