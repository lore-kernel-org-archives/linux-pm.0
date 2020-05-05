Return-Path: <SRS0=9sfO=6T=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9FAC47247
	for <linux-pm@archiver.kernel.org>; Tue,  5 May 2020 06:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C798206E6
	for <linux-pm@archiver.kernel.org>; Tue,  5 May 2020 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588659080;
	bh=HaEcQkyLeK+d1XU6QOn1lwuuBRNuVVKmxwhyolHI43s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sD1bGKgH2YTBTU8eyrykNF7uqgzHWO8ff+0VRaLwvEwI9yf7GEItr2ekVbPCcAc+u
	 yks9KtG462G05g0Vc137VTbYfoaiv3P4DeLHP8B96VFbzbOXv6X11oACksEphQiOtF
	 WxUxxRyKlW2rrg5pUDtjEFGeGXAtNqlVNTjuY9+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgEEGLT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 May 2020 02:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGLT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 02:11:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1722B206A5;
        Tue,  5 May 2020 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588659079;
        bh=HaEcQkyLeK+d1XU6QOn1lwuuBRNuVVKmxwhyolHI43s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aJ49l5hSTg84/ioZxXIX7Rptkf2Lp4cth2XlZchiP9tE0ZlmQFZ4hHLCbQzG4h17c
         hD172j5i1g6tDaBBDTKanbLxbycbQuSaRdzZ7K3wxvmqb/T3ZF/4DV3f2LzUZNln2S
         I+bazqyL2YHkfDQ6GvLd4vQu8WhYYNMArq8KWgFM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200421083000.16740-2-ykaukab@suse.de>
References: <20200421083000.16740-1-ykaukab@suse.de> <20200421083000.16740-2-ykaukab@suse.de>
Subject: Re: [PATCH v2 2/2] clk: qoriq: add cpufreq platform device
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>, andy.tang@nxp.com,
        leoyang.li@nxp.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, shawnguo@kernel.org
Date:   Mon, 04 May 2020 23:11:18 -0700
Message-ID: <158865907823.24786.455613165650100774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Mian Yousaf Kaukab (2020-04-21 01:30:00)
> Add a platform device for qoirq-cpufreq driver for the compatible
> clockgen blocks.
>=20
> Reviewed-by: Yuantian Tang <andy.tang@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
