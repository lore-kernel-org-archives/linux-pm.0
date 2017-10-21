From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 3/4] thermal/drivers/hisi: Prepare to add support for
 other hisi platforms
Date: Sat, 21 Oct 2017 21:58:47 +0200
Message-ID: <d48f2733-72a4-ea0c-d57a-a1962a163117@linaro.org>
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
Received: from mail-wr0-f169.google.com ([209.85.128.169]:53951 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbdJUT6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2017 15:58:51 -0400
Received: by mail-wr0-f169.google.com with SMTP id u40so8023725wrf.10
        for <linux-pm@vger.kernel.org>; Sat, 21 Oct 2017 12:58:50 -0700 (PDT)
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

I would like to reproduce it in order to send a correct fix. I'm not
sure about the const function pointer.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
