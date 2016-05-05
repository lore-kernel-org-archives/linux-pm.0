From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/5] ARM: dts: Add binding documentation for AXP20x
 pmic ac power supply
Date: Thu, 5 May 2016 17:30:58 -0500
Message-ID: <20160505223058.GA28732@rob-hp-laptop>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
 <1462444508-9363-4-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36893 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbcEEWbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 18:31:05 -0400
Content-Disposition: inline
In-Reply-To: <1462444508-9363-4-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Haas <haas@computerlinguist.org>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, hdegoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com

On Thu, May 05, 2016 at 12:35:06PM +0200, Michael Haas wrote:
> Add binding documentation for the ac power supply part of the AXP20x
> pmic.
> 
> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> ---
>  .../bindings/power_supply/axp20x_ac_power.txt           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt

Acked-by: Rob Herring <robh@kernel.org>
