Return-Path: <SRS0=atnh=3Y=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6CAC35247
	for <linux-pm@archiver.kernel.org>; Tue,  4 Feb 2020 20:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C6921741
	for <linux-pm@archiver.kernel.org>; Tue,  4 Feb 2020 20:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWGJ+dSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgBDUxU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:53:20 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:36127 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBDUxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 15:53:19 -0500
Received: by mail-lf1-f47.google.com with SMTP id f24so13218677lfh.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 12:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbz0NUtHrX5+9NCsIDjLoROPzOMAU3z/LAiNTsiqUwg=;
        b=sWGJ+dSvvG9wR5X2wfuBksFQwQ1k25rl4PoAGW6Nps+GvZgn9DNv/c9hWCi1pooqpu
         UTO1G7fAFOaZxR1wRCykcXsF9vfPFRpfRclIPkP0AM1ZUNLcH54PJeMOsP/T6yXdjK7U
         vsyMZHM6IdxshvjEHx84YdlFOE07VSRLyB5B1Y/6LXkVD8Ll1K4xM1oC6nqYIDNmqfPG
         UisvXMHp1x3bMAv6AgwMHVMqwxVtfQ8V84+joKMBZJaRdKdSLFALGa9ur7+3Vib19Wg6
         h9HXZJx6IOC5DfXq1FARoy+Zc2MRCZP+GV31VVpkW71G6W/ZmmM2vpx5D36IxWVkptwo
         V6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbz0NUtHrX5+9NCsIDjLoROPzOMAU3z/LAiNTsiqUwg=;
        b=khuutwi7m6VicRKJNi903sf3Wi1es46fFSVLbzihPTB2CjAULXpo70U0axh0TNcy4X
         cXK5mwyBP/UoFg3+rBMeRGBtDM0ZHhdiKBJ8QLFbOR5eH2dZ6XeTTy8vkS6MGi8l1r4O
         QOejMxTlLqfdKwOlkg4nrnBpFRaiaRiclha/OLX2+le1QErywe5Jw+vkRQezUHVgDVuE
         YHb62LHP6MM61fRYbdfuNbslp0FUDW2DxaouLLTKm6p42Ljovu9tI5fU9zF2pp+eBihn
         nqnpod1Cpm+4+2OHR27IcnvQLDqRMeSc4RF4FGTauV+m5ByZNZBSAqHTTEoYNOpfGz7/
         Qu+g==
X-Gm-Message-State: APjAAAUJOydMCvalYczVxiKhQzDPH8fGWnqj7fX2sLA5p4vy+xVjSboP
        ci6Ecm9Fdf/KaCGKHEXmbvLOkylrP/rfeL9spfojSA==
X-Google-Smtp-Source: APXvYqyk4OpeIu64Tg6Fe/5AKMjkzII/My9BHyYTGERDiPWWOItOV4ENUVCRLLVVu3ZLXvwnpG8fcGNPOaN/ndDek84=
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr15812680lfg.34.1580849595879;
 Tue, 04 Feb 2020 12:53:15 -0800 (PST)
MIME-Version: 1.0
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org> <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
In-Reply-To: <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Tue, 4 Feb 2020 12:52:39 -0800
Message-ID: <CAE=gft7Ypxp6yokyqc3fzG+JaVv_eRjNaYoiiHAFTpjo0hVVRQ@mail.gmail.com>
Subject: Re: [V2, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sboyd@kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 31, 2019 at 1:00 AM Odelu Kukatla <okukatla@codeaurora.org> wrote:
>
> Add the DT nodes for the network-on-chip interconnect buses found
> on sc7180-based platforms.
> ---

Hi Odelu,
Are you going to spin this series?
-Evan
