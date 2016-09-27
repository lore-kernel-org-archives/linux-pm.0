From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] of: thermal: Fixed governor at each thermal zone
Date: Tue, 27 Sep 2016 06:22:05 -0700
Message-ID: <20160927132202.GA27366@localhost.localdomain>
References: <1474247932-1026-1-git-send-email-hugh.kang@lge.com>
 <1474940817.4284.0.camel@intel.com>
 <10649ba4-5558-ea3b-a03b-02babd5e63f9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33471 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754349AbcI0NWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 09:22:09 -0400
Content-Disposition: inline
In-Reply-To: <10649ba4-5558-ea3b-a03b-02babd5e63f9@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Inhyuk Kang <hugh.kang@lge.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Lukasz, Inhyuk, Javi,

On Tue, Sep 27, 2016 at 12:52:04PM +0100, Lukasz Luba wrote:
> 
> On 27/09/16 02:46, Zhang Rui wrote:
> >On 一, 2016-09-19 at 10:18 +0900, Inhyuk Kang wrote:
> >>It is necessary to be added governor at each thermal_zone.
> >>Because some governors should be operated in the during the kernel
> >>booting
> >>in order to avoid heating problem.
> >>
> >>Default governor cannot be covered all thermal zones policy because
> >>some thermal zones want to apply different one.
> >>For example, the power allocator governor operates differently with
> >>step wise governor.
> >>Hence, it is better to parse governor parameter from the device tree.
> >>
> >>Signed-off-by: Inhyuk Kang <hugh.kang@lge.com>
> >>
> >The patch looks okay to me.
> >Eduardo, what do you think of this patch?
> Hi Rui,
> 
> Beside the fact which Javi pointed out in his email, there is an issue in
> the patch itself.
> The idea behind the patch is good, but the patch should have some
> improvements, i.e:
> - strncpy instead of strcpy,
> - if the governor name is not found in the registered governor's list by
> __find_governor (and then null is set) we should probably switch to default
> governor,
> - add DT documentation,

Also, the idea of the patch is good, almost tempting to do it, but
unfortunately, not acceptable from DT perspective. The patch infringes
two of the DT conceptual and design decision of:
(a) DT should describe hardware, not policy;
(b) DT should describe hardware, not OS specific implementations.

As already pointed by Javi, this patch has already been proposed (more
than one time by different people), but, it still continues to be
unacceptable.

Cheers,


> 
> Regards,
> Lukasz
> 
