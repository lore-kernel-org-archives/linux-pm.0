Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD98C433DF
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7478422CAD
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 06:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596610093;
	bh=lxUXrmtcYyYIsbf10qPk2tB/GpQBGm5ms4pwycahUII=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QXyOW80md3rifBi/5+Q4gqc09wy+YUU4GoLkMCYEje39rAc3BUrPIbkH+mJG1IU45
	 fdMmRAuXagF/au7o0K4E/Itb6mT6QZqprggk2enfmcehEKt0AZ1hJAckiXFk+s3EdJ
	 rZCLbjkN7unUvxv92pEMUzrnJXhWKuMxUXk3+8Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgHEGsM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEGsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 02:48:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1162E2076E;
        Wed,  5 Aug 2020 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596610092;
        bh=lxUXrmtcYyYIsbf10qPk2tB/GpQBGm5ms4pwycahUII=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W9F+jzX3WAsT1XK7nkUL+HjTejTSe2aMA0xeQ9cwI6gJT5sN5EKn9Bqb9SrZ6y0iQ
         VEL8ciAvWttha/ISJDEY8+jEbuPhBqbeZGLrbb6ZO10SRIuXKJyLN1Yt2sQ4xo4G3u
         /si2QuMfvR5owOIKGJxhDEmilrhiLdWzLeclhVTw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
Subject: Re: [PATCH v2 1/2] thermal: qcom-spmi-temp-alarm: Don't suppress negative temp
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 04 Aug 2020 23:48:10 -0700
Message-ID: <159661009082.1360974.366976291381142141@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Guru Das Srinagesh (2020-07-29 09:52:51)
> From: Veera Vegivada <vvegivad@codeaurora.org>
>=20
> Currently driver is suppressing the negative temperature
> readings from the vadc. Consumers of the thermal zones need
> to read the negative temperature too. Don't suppress the
> readings.
>=20
> Fixes: c610afaa21d3c6e ("thermal: Add QPNP PMIC temperature alarm driver")
> Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
