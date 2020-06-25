Return-Path: <SRS0=fkE9=AG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06696C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAAD20773
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 10:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbgFYKWt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:49608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403773AbgFYKWg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 06:22:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA8BCAD17;
        Thu, 25 Jun 2020 10:22:34 +0000 (UTC)
Message-ID: <1593080522.28236.17.camel@suse.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Reset port on cmd timeout
From:   Oliver Neukum <oneukum@suse.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        rjliao@codeaurora.org, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Jun 2020 12:22:02 +0200
In-Reply-To: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
References: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, den 24.06.2020, 11:11 -0700 schrieb Abhishek Pandit-
Subedi:
> QCA_ROME sometimes gets into a state where it is unresponsive to
> commands. Since it doesn't have support for a reset gpio, reset the usb
> port when this occurs instead.

Hi,

on first glance this looks like an unbalanced PM reference. It is not
because the operation is suicidal, but this deserves a comment, unless
you want to get a note telling you that you caused an imbalance every
few weeks.

	Regards
		Oliver

