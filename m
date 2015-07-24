From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 14:39:12 +0200
Message-ID: <CAH6sp9ODe9EQjYgkjUr8P-bhhtgshqJovEcOVwKSP_FiuTo8Fw@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
	<20150724122622.GA22105@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38007 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbbGXMjN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 08:39:13 -0400
In-Reply-To: <20150724122622.GA22105@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 24, 2015 at 2:26 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> Thanks for the cleanup patch.
> I have a couple of comments inlined.
>
>> Subject: Re: [PATCH] power_supply: Adjust devm usage
>
> Please make this "power_supply: bq24735: ...".
>
> On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
>> Use devm_kasprintf instead of kasprintf. Also, remove various
>> gotos by direct returns and drop unneeded label err_free_name.
>
> Please also use devm_power_supply_unregister() instead
> of power_supply_unregister() to further simplify the driver.

Sounds like a separate patch.

Frans
