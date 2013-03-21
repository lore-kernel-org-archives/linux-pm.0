From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 15/16] ARM: mvebu: Add thermal support to Armada 370 device
 tree
Date: Thu, 21 Mar 2013 18:03:31 +0400
Message-ID: <514B1333.4030002@cogentembedded.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com> <1363818997-23137-16-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:62583 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933461Ab3CUOEd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 10:04:33 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so5248727lab.9
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 07:04:32 -0700 (PDT)
In-Reply-To: <1363818997-23137-16-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello.

On 21-03-2013 2:36, Ezequiel Garcia wrote:

> This patch depends on the patch to add Armada 370 support
> in the mvebu_thermal driver:
> 'thermal: mvebu: Add support for Armada 370 thermal sensor'

   Sch comments should follow the --- tear line, not precede it.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)

WBR, Sergei

