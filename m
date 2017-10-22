From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 3/4] thermal/drivers/hisi: Prepare to add support for
 other hisi platforms
Date: Sun, 22 Oct 2017 10:55:59 +0200
Message-ID: <46eab5f8-8f50-9c0a-2bc1-075c320dbc7e@linaro.org>
References: <1508512267-18302-1-git-send-email-daniel.lezcano@linaro.org>
 <1508512267-18302-4-git-send-email-daniel.lezcano@linaro.org>
 <20171020205829.GA19087@localhost.localdomain>
 <c202f396-fdc3-70cd-d762-71c088e04ba0@linaro.org>
 <20171021164256.GA30342@localhost.localdomain>
 <CAKnoXLzieT2RwaVr9_Oj6nxsX+CSd_o=uJjxWbdg28p783e72w@mail.gmail.com>
 <20171021190856.GB30342@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46673 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdJVI4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 04:56:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id m72so4412977wmc.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Oct 2017 01:56:02 -0700 (PDT)
In-Reply-To: <20171021190856.GB30342@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Jean Wangtao <kevin.wangtao@linaro.org>, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 21/10/2017 21:08, Eduardo Valentin wrote:
> Heym
> 
> On Sat, Oct 21, 2017 at 08:33:07PM +0200, Daniel Lezcano wrote:
>> What sparse version are you using ?
> 
> 
> Does it really matter? You are still assigning a const pointer to a non-const pointer.

Finally find the installed sparse version I have is a dev version.
Moving back to the distro version showed the warning.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
