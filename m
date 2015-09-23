From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v5 0/6] Add support for additional bq27xxx devices
Date: Wed, 23 Sep 2015 13:41:01 -0500
Message-ID: <5602F23D.80700@ti.com>
References: <1442950511-16122-1-git-send-email-afd@ti.com>
 <20150923164217.GA27606@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35618 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbbIWSl2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 14:41:28 -0400
In-Reply-To: <20150923164217.GA27606@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/23/2015 11:42 AM, Sebastian Reichel wrote:
> Hi Andrew,
>
> On Tue, Sep 22, 2015 at 02:35:05PM -0500, Andrew F. Davis wrote:
>> This series adds support for several additional bq27xxx devices and
>> makes a few related fixes.
>
> Thanks, I queued all remaining patches. I wonder if this driver
> should be converted to regmap. It supports lots of chips now and
> it might be useful to get register dumps from debugfs.
>

I was thinking the same thing, but this driver can also communicate
over the w1 bus which doesn't look like it has the regmap hooks yet.
So I never really found a clean way, outside of bringing up regmap
on w1, to convert this driver over.

Thanks for the queue,
Andrew

> -- Sebastian
>
