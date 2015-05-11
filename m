From: Tai Tri Nguyen <ttnguyen@apm.com>
Subject: Re: [PATCH 0/2] power: reset: Add syscon reboot/poweroff device nodes
 for APM X-Gene platform
Date: Mon, 11 May 2015 12:15:06 -0700
Message-ID: <CACgAJHzxVjg+m+4swXwyGGGf43WkJmxxGOJnXnwA=TwKmJCWTw@mail.gmail.com>
References: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from exprod5og120.obsmtp.com ([64.18.0.137]:59761 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752643AbbEKTPI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 15:15:08 -0400
Received: by qkhg7 with SMTP id g7so93876891qkh.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 12:15:06 -0700 (PDT)
In-Reply-To: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches <patches@apm.com>
Cc: Tai Tri Nguyen <ttnguyen@apm.com>

Hello,

Any comment on these patches, please?

Thanks,
Tai


On Fri, May 1, 2015 at 1:11 PM, Tai Nguyen <ttnguyen@apm.com> wrote:
> This patch set adds syscon reboot/poweroff device nodes to support reboot and
> poweroff features on X-Gene platform.
>
> Tai Nguyen (2):
>   power: reset: Add syscon reboot device node for APM X-Gene platform
>   power: reset: Add syscon poweroff device node for APM X-Gene Mustang platform
>
>  arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  |   12 ++++++++++++
>  2 files changed, 24 insertions(+)
>
> --
> 1.7.9.5
>



-- 
Tai
