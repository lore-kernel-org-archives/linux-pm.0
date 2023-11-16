Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E3C072A2
	for <linux-pm@archiver.kernel.org>; Thu, 16 Nov 2023 00:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKPAgF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Nov 2023 19:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKPAgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:36:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561ECA9;
        Wed, 15 Nov 2023 16:36:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8D0C433C8;
        Thu, 16 Nov 2023 00:36:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id C1B291062B52; Thu, 16 Nov 2023 01:35:56 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
In-Reply-To: <20231111221704.5579-1-jpalus@fastmail.com>
References: <20231111221704.5579-1-jpalus@fastmail.com>
Subject: Re: [PATCH] power: supply: cw2015: correct time_to_empty units in
 sysfs
Message-Id: <170009495675.775272.9542516678978728119.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:35:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sat, 11 Nov 2023 23:17:04 +0100, Jan Palus wrote:
> RRT_ALRT register holds remaining battery time in minutes therefore it
> needs to be scaled accordingly when exposing TIME_TO_EMPTY via sysfs
> expressed in seconds
> 
> 

Applied, thanks!

[1/1] power: supply: cw2015: correct time_to_empty units in sysfs
      commit: f37669119423ca852ca855b24732f25c0737aa57

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

