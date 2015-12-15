From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v4 2/3] power: qcom_smbb: Add otg regulator for control
 of vbus
Date: Tue, 15 Dec 2015 16:36:23 -0600
Message-ID: <20151215223623.GA4246@Agamemnon.attlocal.net>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
 <1450209132-20185-2-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36456 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932885AbbLOWgZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 17:36:25 -0500
Received: by mail-oi0-f48.google.com with SMTP id o62so9439083oif.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 14:36:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450209132-20185-2-git-send-email-tim.bird@sonymobile.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org, Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com

On Tue, Dec 15, 2015 at 11:52:11AM -0800, Tim Bird wrote:
> Add a regulator to control the OTG chargepath switch.  This
> is used by USB code to control VBUS direction - out for host mode
> on the OTG port, and in for charging mode.
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> Changes since v3:
>  - changed DT node name to otg-vbus
>  - removed fixed-voltage setup from otg regulator rdesc
> Changes since v1:
>  - changed name of supply to remove underscores
> ---

Reviewed-by: Andy Gross <andy.gross@linaro.org>
