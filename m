From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [GIT PULL] power supply changes for 4.1
Date: Tue, 14 Apr 2015 22:02:45 +0900
Message-ID: <CAJKOXPdRyF1Y3iNLBaKMH90pDPUyvXwb-zYLP=d31S-ye-Wj7w@mail.gmail.com>
References: <20150413133508.GA3377@earth>
	<CA+55aFyuc35uMsHHFAyNEMq4WodBjNLv58KMt4xOfMW+6Tqe1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f54.google.com ([209.85.216.54]:33065 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbDNNCr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 09:02:47 -0400
In-Reply-To: <CA+55aFyuc35uMsHHFAyNEMq4WodBjNLv58KMt4xOfMW+6Tqe1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sebastian Reichel <sre@ring0.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

2015-04-14 10:09 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Mon, Apr 13, 2015 at 6:35 AM, Sebastian Reichel <sre@ring0.de> wrote:
>>
>>  * new API for safe access of power supply function attrs
>>  * devres support for power supply (un)registration
>
> I'm not sure this is the reason, but suspend/resume on my laptop now
> complains wildly.
>
> I'm *assuming* the culprit is commit 297d716f6260 ("power_supply:
> Change ownership from driver to core") and probably the ACPI changes
> in particular. But I didn't bisect, I'm just pasting the warning
> messages here.

That's my fault. I inverted the logic in if() statement in that
commit. Sorry for that, I'll send a fix.

Best regards,
Krzysztof
