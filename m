From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 19:12:23 +0530
Message-ID: <CAK-LDbKYx3mFP_hLx1xc6s+2dHgk8Hwd8d6sMn40TjHTZX35jw@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
	<20150724122622.GA22105@earth>
	<CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
	<20150724125951.GA25447@earth>
	<CAK-LDbJQ07fi3YOEOJ+8Qwm3jbqA7L8tFNF9U9=_QO0B0gg_UA@mail.gmail.com>
	<20150724133843.GA27569@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38333 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbGXNmY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 09:42:24 -0400
In-Reply-To: <20150724133843.GA27569@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frans Klaver <fransklaver@gmail.com>

On Fri, Jul 24, 2015 at 7:08 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,

Hi,

> On Fri, Jul 24, 2015 at 06:44:41PM +0530, Vaishali Thakkar wrote:
>> [...]
>>
>> This makes sense. Thanks for explanation and review :)
>> So, can I send all changes along with getting rid of remove
>> function here in a single patch?
>
> A single patch is fine for me. Use something like the
> following patch subject then:
>
> "power_supply: bq24735: Convert to using managed resources"

Ok. Sure. I'll send version 2 of a patch with this subject line and detailed
commit log.

Thank You.

> -- Sebastian



-- 
Vaishali
