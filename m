From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: suspend resume query
Date: Thu, 18 Feb 2016 14:54:47 +0800
Message-ID: <CAN2waFtS2cuWw2oY54-DQN_Nt5c=YvXg9nEn2x4vhzZMru9Vrw@mail.gmail.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
	<1455700241.7626.10.camel@suse.com>
	<CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
	<1455702015.7626.13.camel@suse.com>
	<CANMsd03xShJ4hMajaahTaSQfZyCww+9me-e7X3F2=z1oUPN0Cg@mail.gmail.com>
	<1455703562.7626.14.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33651 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbcBRGys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 01:54:48 -0500
Received: by mail-yw0-f171.google.com with SMTP id u200so33274497ywf.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 22:54:48 -0800 (PST)
In-Reply-To: <1455703562.7626.14.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Ryan <ryanphilips19@googlemail.com>, linux-pm@vger.kernel.org

Hi Ryan,
As we already known, STR will let all cores power down after store the
context(GPR, idmap_gpd, sp etc) of primary core in DDR. It is
different between ARMv7 and ARMv8
For ARMv7,
The boot vector can just be located in 0x00000000 or 0xffff0000, which
is chosen by sampling VINITHI domain within PMU register during
bootup. For some SOCs, one of them is used for cold boot while another
is used for recover from STR or CPU IDLE, which is referred as warm
reset. For this scenario, an AON RAM is usually placed in one of the
region mentioned above. Meanwhile, the vendor will place some code
there for bring the core back to the context where it is powered down.

For ARMv8,
All things are covered by PSCI, you can refer the process from ARM's archive.

On 17 February 2016 at 18:06, Oliver Neukum <oneukum@suse.com> wrote:
> On Wed, 2016-02-17 at 15:19 +0530, Ryan wrote:
>> Suspend to ram. I am sorry - I did not provide complete information.
>
> STR on ARM is peculiar. I have no idea.
>
>         Sorry
>                 Oliver
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
