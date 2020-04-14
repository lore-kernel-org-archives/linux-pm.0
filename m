Return-Path: <SRS0=6fVe=56=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3554C2BB85
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9926D20732
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 15:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgDNPzj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:55:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45252 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgDNPzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 11:55:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CF1822A04F7
Subject: Re: [PATCH 0/4] Add support for constant power-supply property tables
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <11e73f71-56f7-328a-ed4d-a4e393ba7265@collabora.com>
Date:   Tue, 14 Apr 2020 17:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

I went through all the patches and Anyway I also tested with cros-usbpd-driver
and they look good to me. I am wondering if you shouldn't constify the users in
this series too, looks pretty trivial?

Cheers,
 Enric

On 13/4/20 20:38, Sebastian Reichel wrote:
> Hi,
> 
> This marks the properties and usb_types entries in
> struct power_supply_desc as const, so that drivers
> can constify those tables.
> 
> -- Sebastian
> 
> Sebastian Reichel (4):
>   power: supply: core: Constify usb_types
>   power: supply: charger-manager: Prepare for const properties
>   power: supply: generic-adc-battery: Prepare for const properties
>   power: supply: core: Constify properties
> 
>  drivers/power/supply/charger-manager.c     | 40 ++++++++++++----------
>  drivers/power/supply/generic-adc-battery.c | 22 ++++++------
>  drivers/power/supply/power_supply_sysfs.c  |  2 +-
>  include/linux/power_supply.h               |  4 +--
>  4 files changed, 36 insertions(+), 32 deletions(-)
> 
