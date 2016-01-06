From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 0/4] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Wed, 6 Jan 2016 10:07:13 +0000
Message-ID: <20160106100712.GA2790@e104805>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34122 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbcAFKHR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Jan 2016 05:07:17 -0500
Content-Disposition: inline
In-Reply-To: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>

On Wed, Jan 06, 2016 at 04:53:44PM +0800, Leo Yan wrote:
> k_po/k_pu are two proportional term constants and essentially they have
> fixed ratio compared with sustainable power. In current implementation,
> k_po and k_pu are absolute value after calculation and cannot represent
> the ratio relationship with sustainable power; as a result, when change
> sustainable power we cannot smoothly change proportional term constant.

In v2 Daniel said that the use case was made up.  Can you elaborate on
why we need this?

> So this patch series introduces k_po_ratio and k_pu_ratio, which
> represent the ratio value compared against sustainable power. Also add
> sys file system nodes for them for easily update them from userspace and
> update a bit in documentation.

Actually, it makes it harder to update from userspace.  Now userspace
can't set a k_po/k_pu any more, and it's forced to set them as ratios
of sustainable power. I'd rather not do this unless there is a good
reason for it.

Cheers,
Javi
