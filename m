Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B6C433E0
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 15:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5AA20825
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594912123;
	bh=/qbr/Yg9xyxtbJ4kf30nsnNmXuoD44yLlvpwirCcvWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dZE0pTekCjYOjNw/fHQCJFPRWTMG87n82XngN9jSzsB6r7II6DQtNdA1idFPEo2G/
	 ypGoe4SmBr3YNcqBKD6c6azlYUfG96KDJTIn8g+sCkfQ0LU2ZK1O3eDVWVRrum35fM
	 vmuzUgL0GfrTkNPA4pmh8HjC80/cboM36cLlDaSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGPPIm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:08:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45681 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 11:08:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id j11so5311411oiw.12
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 08:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gunDMyZfOb5D8oWnjnAEwnjmb5I7q7vedUFV2cSf+4=;
        b=ThkZ78qWLb3g45M65njSk2eiK1CW0n6JaTyrp354TU+XmqhkZXnlNKqsUOErApMtV9
         4eE5loDmXjLKm867AQiWqTrPtva7rdlBLdWX8M0YruHX7G4ZKzmzRRRp8VG/bcHuN+h3
         33g0hJaw9+XGSwpqMvFJg91rtc1VVSUcGx58IUZu+I7i1OcAcwtsqZTKzjpTs3VN4GGU
         zFuyEevbu9jcCso9iLRkFMqiB1u5XLsBVS5Si/is//BAT3rPPIg8X1fTZU4fdCkl1k8t
         KyTYZo+t1W/JKWWq6QBeq/Gs1BK2f2yELXQzXIQGuLm6kwm3FNp6HdXL1fTCAqBtxzPP
         cZdg==
X-Gm-Message-State: AOAM530VckoPmY192SvjXvodbiXNO9BJmt6zuIceP0DcjcqVW+crbX9E
        bMaRuj/0n/X4ijaoP3M7n9p8sHxZ2TrRmc5Amkc=
X-Google-Smtp-Source: ABdhPJwh2yyRA/G4kGuKdjts9HuhUvk6fTexIiu0TGzVmaS586Ek6CaMMUr3iz9hUiYIQrhB0wC1sVwbGcxwmrOo+7I=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr4320592oia.103.1594912121925;
 Thu, 16 Jul 2020 08:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200716033026.uhgnyo6leygfrgac@vireshk-i7>
In-Reply-To: <20200716033026.uhgnyo6leygfrgac@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jul 2020 17:08:30 +0200
Message-ID: <CAJZ5v0jzbyS3HH6eYwut0YMHYm-gfxdGQJH4CqNmT7nM-=tjXQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.8-rc6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thu, Jul 16, 2020 at 5:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request fixes freeing of the OPP entries for the legacy OPP
> table type (v1).
>
> -------------------------8<-------------------------
>
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
>
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes
>
> for you to fetch changes up to 6544abc520f0fff701e9da382110dc29676c683a:
>
>   opp: Increase parsed_static_opps in _of_add_opp_table_v1() (2020-07-16 08:50:54 +0530)
>
> ----------------------------------------------------------------
> Walter Lozano (1):
>       opp: Increase parsed_static_opps in _of_add_opp_table_v1()
>
>  drivers/opp/of.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> --

Pulled, thank you!
