From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Wed, 7 Jun 2017 23:59:12 +0200
Message-ID: <CAJZ5v0j8Jg+KuPNtAY6SS2M2g03i8_m2Eja67XtM7H=ub_1A8A@mail.gmail.com>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170606034135.GA5103@vireshk-i7> <20170607215028.GL2345@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36092 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdFGV7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 17:59:13 -0400
In-Reply-To: <20170607215028.GL2345@mai>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Tao Wang <kevin.wangtao@hisilicon.com>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, amit.kachhap@gmail.com, javi.merino@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, sunzhaosheng@hisilicon.com, Vincent Guittot <vincent.guittot@linaro.org>, jean.wangtao@linaro.org

On Wed, Jun 7, 2017 at 11:50 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Tue, Jun 06, 2017 at 09:11:35AM +0530, viresh kumar wrote:
>> + Daniel
>
> Hi Viresh,
>
> thanks for the head up.
>
> Before going deeply in the review, I have a dumb question:
>
> Why isn't this mechanism implemented at the scheduler level?

I suppose for the same reason why intel_powerclamp is not implemented
like that: the scheduler maintainers don't like the idea.

Thanks,
Rafael
