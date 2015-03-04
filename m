From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Wed, 04 Mar 2015 15:34:06 +0100
Message-ID: <54F717DE.80106@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <54F5CC0D.6060509@libero.it> <54F5D13A.1020002@linaro.org> <3654949.JbH3Ca4PON@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44459 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758117AbbCDOeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 09:34:10 -0500
Received: by wiwl15 with SMTP id l15so31065422wiw.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 06:34:09 -0800 (PST)
In-Reply-To: <3654949.JbH3Ca4PON@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fulvio <fbf@libero.it>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 03/04/2015 03:53 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 03, 2015 04:20:26 PM Daniel Lezcano wrote:
>> On 03/03/2015 03:58 PM, Fulvio wrote:

[ ... ]

>> The fix is correct. The cpu_pm_enter/exit symmetry must be kept beca=
use
>> we don't know what the notifier clients are doing.
>>
>> The point is : can we send it to stable@ as a bug fix or not ?
>
> Yes, we can, unless there's a risk of breaking things that cannot be
> ignored.

Ok, I added the stable@ tag.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

