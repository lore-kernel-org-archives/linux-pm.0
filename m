Return-Path: <SRS0=+GJc=DO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02AC46466
	for <linux-pm@archiver.kernel.org>; Wed,  7 Oct 2020 03:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E08E21527
	for <linux-pm@archiver.kernel.org>; Wed,  7 Oct 2020 03:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZqm6qcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJGDWv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGDWv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 23:22:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40CC0613D2
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 20:22:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so584637edq.12
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lourg1RYIIWpvMWQr+TUObCD9Gx3TD2WZUKJRUks9KE=;
        b=nZqm6qcF6HRSUYLFCRGKoZd6aWjgvq9JFf5HgoJ3L0oAqgW3NjSoU/ig4FvYTuZDUl
         NMBh6WHT/l6//dFKfgbtTbFgX3tBF0z14S2VO7ygvCJgWeHKy1iyZytrc/qyF8hyh2Cw
         EiCUdGhgwObuQVT6J5bNQ3YoKa2n9gxZ6OXLeKFRviIl7VA819vnw94TBnKh+w4ymeve
         A1QoxpwAuw6awYa1el8ezXjUJCLhAy7W16wom9+wt2W4rvEbGeJUI6piUrbcua9eANma
         p0ldgj3w6vTq8ef+EtISgXHmJT043hxqZVkgisHbkHGcvsas2m+S+9eamVLwGN10jl70
         tzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lourg1RYIIWpvMWQr+TUObCD9Gx3TD2WZUKJRUks9KE=;
        b=Cc3l+hQA25fiAP2j98thf+TVWjRRhMMJXue+R60KdA2471E7Shf6KG3CFKrFll6pQO
         vuxtdrJmAGLxQdqE2RdtJ/3K/ws8sKeX6yGSBK6S6SrHaObgyLEpss5YizZ6/y8HFeAU
         +1dsP3krjWz/bWbLnzLm7F80kYjOViz4Bc6msHPNV4nlZWOoF+SxQHmCC/z5LlR/XWYn
         4kD3JOYcjYsVS0xdXIovTNP1ZPSk3CvJHh1AP09s3bjWnC9sCNLrkVyPdJWElmgvXhI6
         hyTWauk11A43bmmoVhQVumgQgFn4iFNPPlMIdLOd03nBqd8neEnDGH4/rSZYB5KuqB22
         r4qA==
X-Gm-Message-State: AOAM532JL+wz0LgwGRrKiOEEU/f1bok7mF20sciDXwr69oR59pphUOZB
        bp9udwhuS0FP4Kh5fCtCbMqnO/XcffletKA/q4P4LAV6bTo=
X-Google-Smtp-Source: ABdhPJyO337FEc7TztOCAntc9Y9EOuRv/DLIXBpzL05wvOzTAu1FuBmcfBNGr0GWpgVS72M81efTsD1h+Asz11So/3U=
X-Received: by 2002:a50:8e43:: with SMTP id 3mr1414659edx.178.1602040969392;
 Tue, 06 Oct 2020 20:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200930062603.29009-4-jun.nie@linaro.org> <202010010818.bTfsOYy0-lkp@intel.com>
In-Reply-To: <202010010818.bTfsOYy0-lkp@intel.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 7 Oct 2020 11:22:38 +0800
Message-ID: <CABymUCPW-xKj37FghscTv2xc6fSxGwwbFCVF6kUjgG3iuj2F4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: avs: qcom-cpr: add support to msm8939
To:     kernel test robot <lkp@intel.com>
Cc:     Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kbuild-all@lists.01.org,
        Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

kernel test robot <lkp@intel.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jun,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on robh/for-next linus/master v5.9-rc7 next-2020=
0930]
> [cannot apply to battery/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Jun-Nie/Support-CPR-on-m=
sm8939/20200930-142825
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it linux-next
> config: x86_64-randconfig-m031-20200930 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> smatch warnings:
> drivers/power/avs/qcom-cpr.c:1957 cpr_fuse_match_tuple() warn: always tru=
e condition '(drv->cpr_fuse_map_match !=3D (-1)) =3D> (0-u16max !=3D (-1))'
>
> vim +1957 drivers/power/avs/qcom-cpr.c
>
Rob,

Thanks for your precious comments! I will fix these issue soon after holida=
y.

Regards,
Jun
