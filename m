From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Sat, 23 Mar 2013 19:38:10 +0100
Message-ID: <514DF692.8030204@gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com> <20130323181638.GN13280@titan.lakedaemon.net> <514DF463.5040506@gmail.com> <20130323183140.GO13280@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:61860 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3CWSiO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 14:38:14 -0400
Received: by mail-ea0-f169.google.com with SMTP id n15so188544ead.28
        for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2013 11:38:13 -0700 (PDT)
In-Reply-To: <20130323183140.GO13280@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

On 03/23/2013 07:31 PM, Jason Cooper wrote:
> On Sat, Mar 23, 2013 at 07:28:51PM +0100, Sebastian Hesselbarth wrote:
>> On 03/23/2013 07:16 PM, Jason Cooper wrote:
>>> On Fri, Mar 22, 2013 at 07:25:00PM -0300, Ezequiel Garcia wrote:
>>> ...
>>>> Ezequiel Garcia (14):
>>>>    thermal: Rename driver 'kirkwood' ->   'mvebu'
>>>>    thermal: mvebu: Rename symbols 'kirkwood' ->   'mvebu'
>>>>    thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
>>>>    thermal: mvebu: Remove unneeded variable initialization
>>>>    thermal: mvebu: Convert to devm_ioremap_resource()
>>>>    thermal: mvebu: Fix license declaration
>>>>    thermal: mvebu: Rename kirkwood definitions to mvebu
>>>>    thermal: mvebu: Add infrastructure to support more multiple SoC
>>>>      variants
>>>>    thermal: mvebu: Add support for Armada XP thermal sensor
>>>>    thermal: mvebu: Add support for Armada 370 thermal sensor
>>>>    thermal: mvebu: Add support for Marvell Dove SoC family
>>>
>>> Once the thermal maintainers agree to take this in, I'll take the three
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Was I not clear?

Just wanted to make sure you or one of the other maintainers didn't
see my note on Patch 11/14. I don't want to send a follow up patch
just because of that ;)

Sebastian

>>> below through mvebu/arm-soc.  This shouldn't cause any dependency
>>> headaches, and will reduce the possibility of merge conflicts.
>>
>> NACK. This patch set breaks thermal on Dove. I sent a mail earlier.

