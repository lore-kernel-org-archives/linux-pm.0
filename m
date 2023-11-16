Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B56C5AE4A
	for <linux-pm@archiver.kernel.org>; Thu, 16 Nov 2023 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbjKPAiu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Nov 2023 19:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjKPAit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A91A1;
        Wed, 15 Nov 2023 16:38:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802AEC433CA;
        Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id 10FCB1062B58; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231031-ref-reboot-mode-v1-1-18dde4faf7e8@quicinc.com>
References: <20231031-ref-reboot-mode-v1-1-18dde4faf7e8@quicinc.com>
Subject: Re: [PATCH] dt-bindings: power: reset: $ref reboot-mode in
 syscon-reboot-mode
Message-Id: <170009512205.785165.1071584386699473443.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:38:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 31 Oct 2023 11:27:00 -0700, Elliot Berman wrote:
> syscon-reboot-mode.yaml should $ref: reboot-mode.yaml, but instead
> rewrites the properties. Update so it $refs instead.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: reset: $ref reboot-mode in syscon-reboot-mode
      commit: 160dff476f81b928ee4a4d2be95066fa32513483

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

