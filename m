Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C67C55186
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D1F2076B
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 00:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587516926;
	bh=1tGsEv5ZFp9bX2M6Kx0sfhTv+0ZAGMG4B0V9Zh/NRjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L3YcxoUH5oJ/ckdQmiURCbdDDGrd2n6KCijaT2TO3wfHM5mefja3wtGIs23KH6z0i
	 HNH+U+xsbz2nDWAtezvBsyu706ACsln7/9OlY19khsVmJhrlShqaSnl6UKKIjN6qoP
	 WfQVk5tyBUIVN40VP2tSMmlvJzHcaMMnruexWTgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDVAzZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Apr 2020 20:55:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B0C2071E;
        Wed, 22 Apr 2020 00:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587516925;
        bh=1tGsEv5ZFp9bX2M6Kx0sfhTv+0ZAGMG4B0V9Zh/NRjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIZ/ySE32plEgTzSYEoFVxtu2f+Ees6F8/H9+vpBCrjILSB53HY7a8zDlU8Gy28XU
         jGiV89vqnJFzcW0fhZ9EGuSjUKvNuvecXtgtyjDYvuFctHpqyN6JQqTBVoTUds1Ln7
         wDuYMMNFP5kbg/+flHoTivANtUtqEQz1ewVHUmFU=
Date:   Tue, 21 Apr 2020 20:55:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.6 084/129] drm/nouveau: workaround runpm fail
 by disabling PCI power management on certain intel bridges
Message-ID: <20200422005523.GV1809@sasha-vm>
References: <20200415113445.11881-1-sashal@kernel.org>
 <20200415113445.11881-84-sashal@kernel.org>
 <CACO55ttpvfoyt1p_5Y-Q1=+5NruF5kMoug85jE9y+jG+FW=HGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACO55ttpvfoyt1p_5Y-Q1=+5NruF5kMoug85jE9y+jG+FW=HGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 15, 2020 at 06:11:10PM +0200, Karol Herbst wrote:
>in addition to that 028a12f5aa829 "drm/nouveau/gr/gp107,gp108:
>implement workaround for HW hanging during init" should probably get
>picked as well as it's fixing some runtime pm related issue on a
>handful of additional GPUs. I have a laptop myself which requires both
>of those patches.
>
>Applies to 5.5 and 5..4 as well.

I've grabbed it for 5.6 and 5.4 (5.5 is EOL), thanks!

-- 
Thanks,
Sasha
