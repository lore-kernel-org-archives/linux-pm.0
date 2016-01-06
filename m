From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 0/4] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Wed, 6 Jan 2016 19:17:09 +0800
Message-ID: <20160106111709.GC1641@leoy-linaro>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
 <20160106100712.GA2790@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33568 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbcAFLRQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 06:17:16 -0500
Received: by mail-pa0-f41.google.com with SMTP id cy9so232214206pac.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2016 03:17:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160106100712.GA2790@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>

Hi Javi,

On Wed, Jan 06, 2016 at 10:07:13AM +0000, Javi Merino wrote:
> On Wed, Jan 06, 2016 at 04:53:44PM +0800, Leo Yan wrote:
> > k_po/k_pu are two proportional term constants and essentially they have
> > fixed ratio compared with sustainable power. In current implementation,
> > k_po and k_pu are absolute value after calculation and cannot represent
> > the ratio relationship with sustainable power; as a result, when change
> > sustainable power we cannot smoothly change proportional term constant.
> 
> In v2 Daniel said that the use case was made up.  Can you elaborate on
> why we need this?

When I did IPA profiling on Hikey, I tried to set different
sustainable power. But after changed sustainable power, k_po and k_pu
were stale value which calculated by old sustainable power.

So with this patch, it's more convinence for profiling and can avoid
confusion for k_po/k_pu after update sustainable power.

> > So this patch series introduces k_po_ratio and k_pu_ratio, which
> > represent the ratio value compared against sustainable power. Also add
> > sys file system nodes for them for easily update them from userspace and
> > update a bit in documentation.
> 
> Actually, it makes it harder to update from userspace.  Now userspace
> can't set a k_po/k_pu any more, and it's forced to set them as ratios
> of sustainable power. I'd rather not do this unless there is a good
> reason for it.

We use ratios of sustainable power to calculate k_po/k_pu, so if user
explicitly specify ratio values we can easily to update k_po/k_pu
after we change sustainable power.

Otherwise, it's hard to get to know the real ratio values of
sustainable power. Please review below case:

- If we set new sustainable power, then actually in kernel it should
  update k_po/k_pu so that can keep fixed ration;
- At the meantime, user can set k_po/k_pu from sys file node so that
  eventually change ratio;

So here has race condition with updating k_po/k_pu and the code is
hard to distinguish what is real real ratio. If have explicit parameters
for ratios, then will be much clear.

Thanks,
Leo Yan
