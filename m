From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Sat, 23 Mar 2013 19:28:51 +0100
Message-ID: <514DF463.5040506@gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com> <20130323181638.GN13280@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:41971 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab3CWS24 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 14:28:56 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so1771635ead.12
        for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2013 11:28:54 -0700 (PDT)
In-Reply-To: <20130323181638.GN13280@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

On 03/23/2013 07:16 PM, Jason Cooper wrote:
> On Fri, Mar 22, 2013 at 07:25:00PM -0300, Ezequiel Garcia wrote:
> ...
>> Ezequiel Garcia (14):
>>    thermal: Rename driver 'kirkwood' ->  'mvebu'
>>    thermal: mvebu: Rename symbols 'kirkwood' ->  'mvebu'
>>    thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
>>    thermal: mvebu: Remove unneeded variable initialization
>>    thermal: mvebu: Convert to devm_ioremap_resource()
>>    thermal: mvebu: Fix license declaration
>>    thermal: mvebu: Rename kirkwood definitions to mvebu
>>    thermal: mvebu: Add infrastructure to support more multiple SoC
>>      variants
>>    thermal: mvebu: Add support for Armada XP thermal sensor
>>    thermal: mvebu: Add support for Armada 370 thermal sensor
>>    thermal: mvebu: Add support for Marvell Dove SoC family
>
> Once the thermal maintainers agree to take this in, I'll take the three
> below through mvebu/arm-soc.  This shouldn't cause any dependency
> headaches, and will reduce the possibility of merge conflicts.

NACK. This patch set breaks thermal on Dove. I sent a mail earlier.

Sebastian


