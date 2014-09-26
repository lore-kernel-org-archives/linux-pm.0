From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] power: Add simple gpio-restart driver
Date: Thu, 25 Sep 2014 20:28:30 -0700
Message-ID: <5424DD5E.3040809@roeck-us.net>
References: <1409167431-21155-1-git-send-email-davidriley@chromium.org> <1409167431-21155-2-git-send-email-davidriley@chromium.org> <541BB278.9010701@roeck-us.net> <20140925234145.GA2063@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33203 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbaIZD2g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 23:28:36 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XXMCx-000fgY-Te
	for linux-pm@vger.kernel.org; Fri, 26 Sep 2014 03:28:36 +0000
In-Reply-To: <20140925234145.GA2063@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 09/25/2014 04:41 PM, Sebastian Reichel wrote:
> Hi Guenter,
>
> On Thu, Sep 18, 2014 at 09:35:04PM -0700, Guenter Roeck wrote:
>> On 08/27/2014 12:23 PM, David Riley wrote:
>>> This driver registers a restart handler to set a GPIO line high/low
>>> to reset a board based on devicetree bindings.
>>>
>>> Signed-off-by: David Riley <davidriley@chromium.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Is there an immutable branch available with your restart handler
> stuff, which I can pull into battery-2.6.git?
>
> -- Sebastian
>


Hi Sebastian,

Unfortunately not.

Andrew has the patches in his tree and will hopefully send the set to Linus
during the next commit window. Not sure if/how I could create an immutable
branch from the commits in his repository, especially since (if I understand
it correctly) he re-creates his tree on a regular basis, which is changing
the SHAs and, unless I am missing something, the commit dates.

[ Not really sure how to best handle situations like that .. ]

Guenter

