From: Chris Brand <chris.brand@broadcom.com>
Subject: Re: [PATCH 6/6] arm: dt: bcm23550: Add device tree files
Date: Fri, 6 May 2016 10:49:00 -0700
Message-ID: <CAMsMSK9usB6+tfrUFwhBW+WUc1rW3eNmWG-SCy5RF7JydsWRZg@mail.gmail.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
	<1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
	<9191808.kbIrFQuH7z@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36025 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcEFRtB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 13:49:01 -0400
Received: by mail-ig0-f178.google.com with SMTP id u10so52518805igr.1
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2016 10:49:01 -0700 (PDT)
In-Reply-To: <9191808.kbIrFQuH7z@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@armlinux.org.uk>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>

On Thu, May 5, 2016 at 2:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 05 May 2016 13:48:54 Chris Brand wrote:
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200n8";
>> +       };
>> +
>>
>
> Can you move this into the .dts file, and add a stdout-path
> property to make earlycon work?
>
>         Arnd

Will do. Thanks, Arnd.

Chris
