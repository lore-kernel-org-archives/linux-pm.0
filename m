Return-Path: <SRS0=NsZF=A7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F509C433E5
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1768F207FC
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595288182;
	bh=5wUWZTgLDGHLY0b9AD8FrjBZZ27JrDASbzC7CTV8awo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Zik13bKMzccKbDrD3r3pW2yPcGAGPkRyxODW5UMF+ebuYqb98oG3GmD1IDReLAGhT
	 8WzLvYNi+a2jWexkNmTpZxj1ZUKPB91y6I3fhYZEwW/+/0LKcZhGrmyambroW+24YS
	 zMR6eRSxsl/HEzsggoOlw9wntOYpMwRO93Rp105s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGTXgT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGTXgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jul 2020 19:36:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B7A207FC;
        Mon, 20 Jul 2020 23:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595288178;
        bh=5wUWZTgLDGHLY0b9AD8FrjBZZ27JrDASbzC7CTV8awo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BgQvT4o5Xpt82FGLtEwXj3nshT+vjMtfX6VHZMJTEIgEO46oS3TgO1SqLnA8m2XkQ
         cIlprELy2O+YaNRBHmK4tglrXTbh9YQGNZXIKLuMqTmnPrdK6uJoGramddqH9+9dNr
         VpoviPyZczNy9iFhCCwJUZmzydaHDIg6J0Z2JNYc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP245DUqvTYENmaxG3rjUn1XrzrmvdFmKG_vaef2BxKL6jY+Rg@mail.gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-2-ansuelsmth@gmail.com> <CAP245DUqvTYENmaxG3rjUn1XrzrmvdFmKG_vaef2BxKL6jY+Rg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] ipq806x: gcc: add support for child probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
Date:   Mon, 20 Jul 2020 16:36:17 -0700
Message-ID: <159528817752.3847286.2725374997908705208@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2020-07-20 02:41:44)
> On Thu, Jul 16, 2020 at 7:58 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > Add support for child probing needed for tsens driver that share the
> > seme regs of gcc for this platform.
>=20
> Typo: same
>=20

Otherwise reviewed-by? Because I can throw this into the clk tree with
the typo fixed.
