Return-Path: <SRS0=SRLr=7L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DCC433E2
	for <linux-pm@archiver.kernel.org>; Fri, 29 May 2020 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364A72072D
	for <linux-pm@archiver.kernel.org>; Fri, 29 May 2020 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590773626;
	bh=z5JkNzmIE+RdJy6waG7+tlJhps7gYJ8N5inbXpoiBng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mxe3EIbgO60x5P1Lm2WRf96ArUmv9EtktN42IJzrX5GH8b5qEcZfZjq9whhGnGygg
	 dG9ZwvJSw2MxwqkhtxYdPDaCTSOcw+GlqAAY7Uc9YtPbJ1+ul9FJe4HDzgQlSwDE+F
	 FUnd+Q1wMhZKxAyJqHhC9aN08YySly/sGRF+BGVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgE2Rdm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 29 May 2020 13:33:42 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37501 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2Rdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 13:33:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id mb16so2855500ejb.4;
        Fri, 29 May 2020 10:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PszhtAwUwwlJ09xeuuN/pO1JWqOLkuSHz7sxH2UKeTE=;
        b=ljsFLDKbFzxxve6rCp79GQeVuJbYjNaGeji8kKrEryqZ73+1u/UfggSaZXYH7s97uF
         GZ3b4Xr9wEvOdMFssodcEEkkcpEm13WG6ftRy1EgKxV9wqM1XOIDU8xGVW4/YARnYriD
         FTAxmBKWg9nm4HFIgwBHGwYJbC9NMHAnz12RTsoHl2BwY3KbUJOdGOR+tW5+1cPBif2z
         bVhywxE/5z9CBTZ2gmePR0jGfdg4TwBLrNd4Wfp2XBg8v/A3+JJ+FhT0l+adp5X0kkZo
         SyXgX/BGH22hF8Tv4W5/CctywlAjZVvySo9w8XD5O82VWO3GwtcnF0pWCYLra4C6aNnj
         lwNQ==
X-Gm-Message-State: AOAM532PHbbQ0pR1l3Aks1Gw3yN0E0LgYXCaDBNXD/G1zegrIvju2XRM
        VzBP5paH0v48UMBa5vTKIfk=
X-Google-Smtp-Source: ABdhPJyNrwdibGKDjwG2u2mVPxTu3VxK3FigRubMSp4DXgAyfIUx0rd177S7EUDIxfFpk+50i/9Q0Q==
X-Received: by 2002:a17:906:ce36:: with SMTP id sd22mr8463743ejb.94.1590773615802;
        Fri, 29 May 2020 10:33:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id kt10sm3513669ejb.54.2020.05.29.10.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 10:33:35 -0700 (PDT)
Date:   Fri, 29 May 2020 19:33:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, peron.clem@gmail.com,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] Fix regulators coupling for Exynos5800
Message-ID: <20200529173332.GA20540@kozik-lap>
References: <CGME20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632@eucas1p1.samsung.com>
 <20200529124940.10675-1-m.szyprowski@samsung.com>
 <159077112408.28818.15178843458792850223.b4-ty@kernel.org>
 <20200529165827.GP4610@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529165827.GP4610@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 29, 2020 at 05:58:27PM +0100, Mark Brown wrote:
> On Fri, May 29, 2020 at 05:52:15PM +0100, Mark Brown wrote:
> 
> > [1/1] regulator: extract voltage balancing code to the separate function
> >       commit: 752db83a5dfd4fd3a0624b9ab440ed947fa003ca
> 
> Let me know if you need a pull request for this - I figured it was too
> late to apply the second patch before the merge window with the cross
> tree stuff.

Thanks, I think it will not be needed. I'll apply the second patch after
the merge window.

Best regards,
Krzysztof

