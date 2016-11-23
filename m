From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 2/2] power: supply: add sbs-charger driver
Date: Wed, 23 Nov 2016 09:17:10 +0800
Message-ID: <b84c933d-6186-a67b-c35f-486335e2ed28@electromag.com.au>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-3-git-send-email-nicolas.saenz@prodys.net>
 <d5340efc-b3b4-a247-ed85-b8f117294f40@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:47785 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756464AbcKWBRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 20:17:13 -0500
In-Reply-To: <d5340efc-b3b4-a247-ed85-b8f117294f40@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicola Saenz Julienne <nicolas.saenz@prodys.net>, sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 23/11/2016 09:06, Phil Reid wrote:
> G'day Nicola,
>
> On 22/11/2016 02:04, Nicola Saenz Julienne wrote:
>> This adds support for sbs-charger compilant chips as defined here:
>> http://sbs-forum.org/specs/sbc110.pdf
>>
>
> You may want to look at the series: power: supply: sbs-manager add driver.
> http://www.spinics.net/lists/linux-i2c/msg26383.html
>
> This is the same thing that Karl-Heinz and myself particpated on.
>
> We've had some trouble getting the device tree binding approved thou.
>
> In particular it handles multiple sbs-batteries thru an i2c mux.
>
> Have a look and let me know what you think. Sebastians comment on the irq thing looks interesting
> There does look to be some nice additional features in your driver.
>
> I've been distracted with other things but if you want to progress it I'm happy to help with testing etc.
>
> Dual battery support is a must for me thou.
>

Sorry Ignore all that.
Just realised its a different device. charger vs combined manager / charger.



-- 
Regards
Phil Reid


