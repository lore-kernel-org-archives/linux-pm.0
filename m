From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 1/9] PM / Domains: Ignore domain-idle-states that are
 not compatible
Date: Sun, 12 Mar 2017 09:35:15 -0500
Message-ID: <20170312143515.aodwv66ltyznrjj5@rob-hp-laptop>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
 <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34044 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbdCLOfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 10:35:18 -0400
Content-Disposition: inline
In-Reply-To: <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org

On Fri, Mar 03, 2017 at 12:41:27PM -0800, Lina Iyer wrote:
> domain-idle-states property may have phandles to idle state bindings
> that may not be compatible with idle state definition defined in [1].
> Such phandles would just be ignored and not throw and error when read by
> the domain core.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt |  4 +++-
>  drivers/base/power/domain.c                              | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
