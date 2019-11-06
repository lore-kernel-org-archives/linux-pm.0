Return-Path: <SRS0=tRrS=Y6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A3C5DF63
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3B72187F
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573066976;
	bh=+8TaTPP+s7V+bVyZM+p1huKbxLpHumxhlcmvA+KgfoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=NT3/skfY90ue+JuGgmGjha1f3LG1VSr0mKD54rrXgD3wq/ov3uG8h++7yOvj+k0sG
	 /ZtAd+N7GGEoaoNGEu0HXSCHLiZ4Kgpt3OjDTvEGHzRwfVS1VVx13sl3T4m/DlFMbR
	 wdCYZKOSuXkMiJUK9+FxB2uNb6zgmLsGUC/I9rY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfKFTCx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfKFTCx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:53 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E5220869;
        Wed,  6 Nov 2019 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573066972;
        bh=+8TaTPP+s7V+bVyZM+p1huKbxLpHumxhlcmvA+KgfoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RH9E3HRrbnyNisCfWjcCsSlXQculBNgWbDTA88JGU+YwV6938EzsZVUAa+IJEoLm+
         +O8E3ykFBgKavdcmMSG6KxkkC+19KeuEmT6fYTLk6WF1EYNHA9PZej8CoAkdkSkiTH
         Wjp72nedyML4MlaBk+CZ1+SCws9FcDPTRu0CGI5Y=
Date:   Wed, 6 Nov 2019 13:02:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Message-ID: <20191106190250.GA238633@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This series rearranges some PCI power management code to make it somewhat
> easier to follow and explicitly consolidate the power-up (transitions to
> D0) code path.
> 
> It is not intended to change the functionality of the code.

Applied with Mika's reviewed-by to pci/pm for v5.5, thanks!

Thanks for the git tips, too!
