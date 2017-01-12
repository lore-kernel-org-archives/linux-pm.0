From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 1/3] dt: bindings: add documentation for zx2967 family
 thermal sensor
Date: Thu, 12 Jan 2017 08:40:48 +0800
Message-ID: <20170112004047.GA31366@dragon>
References: <1484129651-17531-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbdALAlb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 19:41:31 -0500
Content-Disposition: inline
In-Reply-To: <1484129651-17531-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

On Wed, Jan 11, 2017 at 06:14:09PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Shawn Guo <shawnguo@kernel.org>

Rob already gave his ACK on v1.  Since v2 is just an improved version of
v1 (without significant rewriting), you should add his ACK tag, so that
thermal maintainers know that the bindings has been ACK-ed by DT
maintainer.

Shawn
