From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] PM / devfreq: exynos: Add the detailed correlation
 for Exynos5422 bus
Date: Mon, 11 Apr 2016 10:45:14 -0500
Message-ID: <20160411154514.GA29936@rob-hp-laptop>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58325 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbcDKPpU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Apr 2016 11:45:20 -0400
Content-Disposition: inline
In-Reply-To: <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, rjw@rjwysocki.net, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Apr 08, 2016 at 02:00:41PM +0900, Chanwoo Choi wrote:
> This patch adds the detailed corrleation between sub-blocks and power line
> for Exynos5422.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This belongs with your previous series. Probably, all of this should be 
1 DT patch rather than piecemeal. Any division should be by h/w block, 
not as a driver is using features.

Rob
