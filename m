Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2AC55186
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05712076C
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549070;
	bh=bLJbp6+zinXZf+o+3jQEHKbAguMOzTp9z4BWNRFsioo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WdH31n0j9qWciM1tvyIqPPQWMQG6/AC7rsYiWxdmvyq+8P3HwlMQyCdBlR8nt4cn8
	 Hu1iQryankiOF6lr+fv/jw65hrXIqfHa4tGkGAhAZ3P+ZqL3AzTzpDZmsV7ocip9jb
	 gSineAYK6YZTjc76rfXBA5ik4I/kWEp38zOzHU5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVJvJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJvJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 05:51:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17BB2073A;
        Wed, 22 Apr 2020 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549068;
        bh=bLJbp6+zinXZf+o+3jQEHKbAguMOzTp9z4BWNRFsioo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=0tApOW/IF82Eyo4QYx0jHf79aQWnMBt4tiFgAQiWawt/Hk5icbg9am6XY+7DqRmuN
         zt+gvXfeCjBOOG2tK1rcbSZ9xX2TmE6UiLZ+mShYcpTX/2wuAFACXBnYOQ5WALzdlK
         OyMw7LUKAWkkHP4PO/2baErwXnqGV5FU2ZnarNOU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200419170810.5738-16-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-16-robh@kernel.org>
Subject: Re: [PATCH 15/17] vexpress: Move site master init to vexpress-config bus
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 22 Apr 2020 02:51:08 -0700
Message-ID: <158754906803.132238.5380277174069330915@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Is the subject supposed to say 'set master' vs. 'site master'?

Quoting Rob Herring (2020-04-19 10:08:08)
> There's only a single caller of vexpress_config_set_master() from
> vexpress-sysreg.c. Let's just make the registers needed available to
> vexpress-config and move all the code there. The registers needed aren't
> used anywhere else either. With this, we can get rid of the private API
> between these 2 drivers.
>=20
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
