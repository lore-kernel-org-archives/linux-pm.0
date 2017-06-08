From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Thu, 8 Jun 2017 09:52:24 +0200
Message-ID: <20170608075224.GN2345@mai>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170606034135.GA5103@vireshk-i7>
 <20170607215028.GL2345@mai>
 <CAJZ5v0j8Jg+KuPNtAY6SS2M2g03i8_m2Eja67XtM7H=ub_1A8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35579 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdFHHwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 03:52:30 -0400
Received: by mail-wm0-f42.google.com with SMTP id x70so71792657wme.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 00:52:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j8Jg+KuPNtAY6SS2M2g03i8_m2Eja67XtM7H=ub_1A8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Tao Wang <kevin.wangtao@hisilicon.com>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, amit.kachhap@gmail.com, javi.merino@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, sunzhaosheng@hisilicon.com, Vincent Guittot <vincent.guittot@linaro.org>, jean.wangtao@linaro.org

On Wed, Jun 07, 2017 at 11:59:12PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 7, 2017 at 11:50 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On Tue, Jun 06, 2017 at 09:11:35AM +0530, viresh kumar wrote:
> >> + Daniel
> >
> > Hi Viresh,
> >
> > thanks for the head up.
> >
> > Before going deeply in the review, I have a dumb question:
> >
> > Why isn't this mechanism implemented at the scheduler level?
> 
> I suppose for the same reason why intel_powerclamp is not implemented
> like that: the scheduler maintainers don't like the idea.

Ok, I see.

Thanks.

  -- Daniel


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
