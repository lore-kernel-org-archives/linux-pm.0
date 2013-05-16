From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/6] Thermal: armada_thermal: Remove redundant
 platform_set_drvdata()
Date: Thu, 16 May 2013 16:46:26 +0800
Message-ID: <1368693986.2063.40.camel@rzhang1-mobl4>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
	 <5183B1B0.5030806@ti.com>
	 <CAK9yfHy0fjYt3h4-E5rspARJGAfA1rtvGGiHrNhhbWuQ-fbkwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6898 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788Ab3EPIqb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 May 2013 04:46:31 -0400
In-Reply-To: <CAK9yfHy0fjYt3h4-E5rspARJGAfA1rtvGGiHrNhhbWuQ-fbkwg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

On Thu, 2013-05-16 at 13:39 +0530, Sachin Kamat wrote:
> On 3 May 2013 18:16, Eduardo Valentin <eduardo.valentin@ti.com> wrote:
> > On 03-05-2013 05:57, Sachin Kamat wrote:
> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> >> driver is bound) removes the need to set driver data field to
> >> NULL.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >
> > I am fine with this patch.
> >
> > Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> Ping on this series Rui :)
> 
I think I've applied this patch set.
sorry that I did not reply the email.
all patches are in thermal -next tree now.

thanks,
rui


