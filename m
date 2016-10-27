From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH V4 0/5] firmware: Add support for TI System Control
 Interface (TI-SCI) protocol driver
Date: Thu, 27 Oct 2016 20:46:30 +0300
Message-ID: <f51516ba-9539-78ca-1d40-585ece047ea0@ti.com>
References: <20161018230837.6515-1-nm@ti.com>
 <2694e4b5-20d5-f590-c6a6-55ff4cb8c16b@ti.com> <m260odhjcb.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53550 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934200AbcJ0RrL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Oct 2016 13:47:11 -0400
In-Reply-To: <m260odhjcb.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Andrew Davis <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>

On 27/10/16 19:01, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> On 19/10/16 02:08, Nishanth Menon wrote:
>>> Version 4 of the series is basically a rebase to v4.9-rc1, no functional
>>> changes.
>>
>> Any final comments on this series, or shall I send a pull-req forward?
>> Very minimal changes compared to v3 so should be good to go imo.
>
> Not a comment on the series, but a question on TI-SCI.
>
> Will the uC firmware be open like it was on AM335x?

Currently it seems like it will be closed. :(

-Tero
