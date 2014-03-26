From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 00/14] CPU idle for Armada XP
Date: Wed, 26 Mar 2014 10:53:26 +0100
Message-ID: <5332A396.50802@free-electrons.com>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com> <20140326004223.GL28304@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51920 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751130AbaCZJxa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 05:53:30 -0400
In-Reply-To: <20140326004223.GL28304@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org

On 26/03/2014 01:42, Jason Cooper wrote:
> Gregory,
> 
> On Tue, Mar 25, 2014 at 11:48:11PM +0100, Gregory CLEMENT wrote:
> ...
>> The first patch should go through ARM subsystem and should be taken by
>> Russell King. I made few change on it following Lorenzo advice and
>> now it will reuse the cpu v7 suspend and resume function and just do
>> specific operation before calling them.
>>
>> The 13th patch 'cpuidle: mvebu: Add initial cpu idle support for
>> Armada 370/XP SoC' is the only one who should go to the cpuidle
>> subsystem. But of course I would like that Daniel Lezcano or Rafael
>> J. Wysocki have a look on the whole series and especially patches 10,
>> 12 and 14.
> 
> Ok, I'm tired.  :)  Help me out here.  Patches 1 and 13 are depended on
> by the other patches and vice-versa, right?  In that case, I'm thinking
> it's best to seek Acks from the other maintainers and keep the whole
> branch together.  Please tell me if I'm wrong.
> 

Actually for the build there is no dependencies between patch 1, 13 and the
other ones.

About running the kernel obviously you need the full series to have the CPU
idle working, but if patch 13 is not applied or if it is applied alone, the
kernel won't crash, the only consequence will be that the cpu idle driver won't
be loaded.

If all patches are applied except patch 1 then we could experiment some issues.
However, now the the amount of code is very small in this patch, I planed
to submit it to Russell King's patch system soon.

About patch 13, I agree that if Daniel and Rafael agree to give their acked-by,
it will be easier to handle if you can take it in a single series, but it is not
mandatory.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
