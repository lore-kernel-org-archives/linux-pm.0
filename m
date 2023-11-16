Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF9C072A2
	for <linux-pm@archiver.kernel.org>; Thu, 16 Nov 2023 00:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjKPAit (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Nov 2023 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKPAis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6254187;
        Wed, 15 Nov 2023 16:38:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69023C433C8;
        Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id 172AA1062B61; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231031-ref-nvmem-reboot-mode-v1-1-c1af9070ce52@quicinc.com>
References: <20231031-ref-nvmem-reboot-mode-v1-1-c1af9070ce52@quicinc.com>
Subject: Re: [PATCH] dt-bindings: power: reset: $ref reboot-mode in
 nvmem-reboot-mode
Message-Id: <170009512207.785165.11427620584398250645.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:38:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 31 Oct 2023 11:28:22 -0700, Elliot Berman wrote:
> nvmem-reboot-mode.yaml should $ref: reboot-mode.yaml, but instead
> rewrites the properties. Update so it $refs instead.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: reset: $ref reboot-mode in nvmem-reboot-mode
      commit: 5739da3e16ad0ebe99c31cabe960856b53eaaabe

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

