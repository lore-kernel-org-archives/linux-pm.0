Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC76C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 06:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DDB2076E
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596610113;
	bh=HMyvD8NsGy2u833AuNGlzuWSRw2uA7wsTK0RAPThsLI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QwBWo5k/l/erhmLEJENKx5ijDe6n3NKle4qZAPfjIw8I1YENyqU0wswOZnggUo9vZ
	 Qm9AKDelwLhKuglLuIMTsvclWPRtxwT+p7vb+SQceJQQSzJyhvVV9hHvFEPcFnhKsN
	 XBoDPmefIisJXViDSaAyKF7L/wuBTmKdBoEWcZtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHEGsd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHEGsc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 02:48:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E63B2076E;
        Wed,  5 Aug 2020 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596610111;
        bh=HMyvD8NsGy2u833AuNGlzuWSRw2uA7wsTK0RAPThsLI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=18qa1fuhPqZCLDqstMlypKMAv8ES/94BCJdib+oqYTSCI4iBJA+YAyZ9DuPVjN1YY
         mMpfuXN9ceeOTd7xv8zijMYVCvXsOTjff2LE3WZvakhw9+PjJWkTwguUnVS8vFp+Ux
         QO/FkbtdRMvyDtCjMo3X1MRYkfdfBAe2ZnI2JqxI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org> <69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org>
Subject: Re: [PATCH v2 2/2] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 1 PMIC peripherals
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 04 Aug 2020 23:48:30 -0700
Message-ID: <159661011044.1360974.2399567989389491381@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Guru Das Srinagesh (2020-07-29 09:52:52)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
> major revision 1.  This revision utilizes a different temperature
> threshold mapping than earlier revisions.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
