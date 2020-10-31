Return-Path: <SRS0=JyHV=EG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD88C00A89
	for <linux-pm@archiver.kernel.org>; Sat, 31 Oct 2020 02:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B257C22228
	for <linux-pm@archiver.kernel.org>; Sat, 31 Oct 2020 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604112792;
	bh=j66P/8rfLDmmt5pD7qa3SIcgRNbMjqIB54228lznXzY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xRGIyWi3gYSxmG+IS0mm67EgxEDR3mK4+nFoz/yPfXVZhQIC6vBpq8Iwf4ir1FOiZ
	 qGXgY9wPlciukP4EvFCnWJP5mw6+4eqLGFZz+mtVJERmxYgkF44wzDyLZ6ByI65zBq
	 4tozAYd76WRvLijldf/s7vaL8PdSzvvAQzb1d9ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJaCxM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 30 Oct 2020 22:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJaCxM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 22:53:12 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B742071A;
        Sat, 31 Oct 2020 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604112791;
        bh=j66P/8rfLDmmt5pD7qa3SIcgRNbMjqIB54228lznXzY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uksjcPVWdi3hxWqTqSuf8V6j7Cf+i4/NjseJ72rLjQWQCLKUcZxWZmq+uNSnqeDKO
         OZhXkcNFBJxCie7nQcgBYpVn/jw0cmmVfs8+JHREDv/nDbAbD4583VXUuTTkU/HENV
         RLBUg4meA/z+FKMSMLWxLRJm5dGSLTPbA8+QMMOs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201030042000.bo3dwrmi7efoe42v@vireshk-i7>
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org> <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com> <20201029041019.xps4dcavkvk6imp5@vireshk-i7> <20201030042000.bo3dwrmi7efoe42v@vireshk-i7>
Subject: Re: [PATCH] opp: Reduce the size of critical section in _opp_table_kref_release()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
To:     Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 30 Oct 2020 19:53:10 -0700
Message-ID: <160411279004.884498.13305671365226511605@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2020-10-29 21:20:00)
> On 29-10-20, 09:40, Viresh Kumar wrote:
> > Thanks a lot. I was a bit worried about the crazy idea I had to solve
> > this :)
>=20
> Hmm, I thought this is the other patch where I had that crazy idea.
> This one was quite straight forward :)
>=20

What's the other crazy idea patch?
