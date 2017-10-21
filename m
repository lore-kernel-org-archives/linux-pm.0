From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 3/4] thermal/drivers/hisi: Prepare to add support for
 other hisi platforms
Date: Sat, 21 Oct 2017 12:08:58 -0700
Message-ID: <20171021190856.GB30342@localhost.localdomain>
References: <1508512267-18302-1-git-send-email-daniel.lezcano@linaro.org>
 <1508512267-18302-4-git-send-email-daniel.lezcano@linaro.org>
 <20171020205829.GA19087@localhost.localdomain>
 <c202f396-fdc3-70cd-d762-71c088e04ba0@linaro.org>
 <20171021164256.GA30342@localhost.localdomain>
 <CAKnoXLzieT2RwaVr9_Oj6nxsX+CSd_o=uJjxWbdg28p783e72w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:54597 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbdJUTJB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2017 15:09:01 -0400
Content-Disposition: inline
In-Reply-To: <CAKnoXLzieT2RwaVr9_Oj6nxsX+CSd_o=uJjxWbdg28p783e72w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Jean Wangtao <kevin.wangtao@linaro.org>, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Heym

On Sat, Oct 21, 2017 at 08:33:07PM +0200, Daniel Lezcano wrote:
> What sparse version are you using ?


Does it really matter? You are still assigning a const pointer to a non-const pointer.

BR,
