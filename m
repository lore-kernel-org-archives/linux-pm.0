From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Sat, 4 Jun 2016 16:09:53 +0200
Message-ID: <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <20160604140154.GB31801@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbcFDOKC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 4 Jun 2016 10:10:02 -0400
In-Reply-To: <20160604140154.GB31801@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi,

On 04-06-16 16:01, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
>> The usb power-supply on the axp22x pmics is mostly identical to the
>> one on the axp20x pmics. One significant difference is that it cannot
>> measure / monitor the usb voltage / current.
>
> Acked-By: Sebastian Reichel <sre@kernel.org>
>
> What's the merge strategy for this patchset?

All of the separate bits can be merged separately without
problems, so Lee can take the 2 mfd patches, you can take
the power-supply patch and Mark Brown can take the regulator
patch.

I believe that that is the best merge strategy.

Regards,

Hans
