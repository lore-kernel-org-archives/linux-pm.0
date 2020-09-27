Return-Path: <SRS0=/EOH=DE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B6C4346E
	for <linux-pm@archiver.kernel.org>; Sun, 27 Sep 2020 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC73239A1
	for <linux-pm@archiver.kernel.org>; Sun, 27 Sep 2020 20:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar6tqTbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI0UIt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0UIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 16:08:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD9EC0613CE
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2020 13:08:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t10so9668291wrv.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2020 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=KwdukLhR8lEBy3bTttrmXwu2j3UoN5Ovf1bdxuz9rDE=;
        b=Ar6tqTbptUDVW/Flq0sGuX3nfPpL9cej4cIyWUhKJvuhrxeHxz/PNZ0/WCvs6G0geA
         WIUPxsXK+Y6LHUy7GAV3C/akQVGDsVgIH3up7dX0oOMd3Qw6SDuE4SDj81g8g6DPfWiv
         wegQMdG+ytD7enam0bVPMLY4cYK0GG1qLuLfopiy6BhN548ELKbe+wMlXrMNjxy3N6eT
         aXOxjpoWbzEXXpWzZl1TxgXOg6gnjqWH4AOPQii6MeTQAywQDcAV1PDSs0W1R+a3onfP
         pFfH6rgL+xo/4UYyd/Qc7d5eoK/LvIrFMOzE5m1VpYbD04n/Us50wFtc2A0/Lj9nVJHK
         DBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=KwdukLhR8lEBy3bTttrmXwu2j3UoN5Ovf1bdxuz9rDE=;
        b=NToeUDyioPSI78qdOIduawbROJQnKKJsUPCMQGoFkHpY4dgjr0TLUIF1YkZkKbYFQT
         QFN2Zl+Q0amdU+GwX353xsdg2FfECmLi4cg7GDFdFyC7fhpqlhgqQEtayF4T5JQ5ZOkK
         8ESLb+hj1C7xgTCEL7pB20eRFzagio6uGBprnXrg3QbiUCYxww7Fcrgm4VH9/ESLUiOx
         aMYwxCB/6lwx26dlXafArLVpkguc9nDMChvQlO2PAkdp13RgbcK1A2v/sHK4UMwUL7dK
         iQsrMe1fJSnLgMtSHnsCe+UZ8eOOuylXHeF9Sp2k4XgUJpBDzfGLacfIwQu2R3FqP0ZY
         PZmg==
X-Gm-Message-State: AOAM53342GhdNd9+z7MwllRizuiuvPLUnT8I/7nAHmlpJOk1zOGINNrj
        rDXM35UVDSMqp5BTFhNXwtOW44u+x3A=
X-Google-Smtp-Source: ABdhPJwvddZjWIXI3Q8OoRAE9ysbjHdpEAQc7xC1zJgDGgL4Jv4nIs1vkQdgzx9dKE5QY8MaywxQmA==
X-Received: by 2002:adf:8342:: with SMTP id 60mr16719108wrd.158.1601237327534;
        Sun, 27 Sep 2020 13:08:47 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id n4sm10436396wrp.61.2020.09.27.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 13:08:46 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     <linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
Subject: [regression, bisected] =?iso-8859-1?Q?cros=5Fec=5Fspi=5Fhig_100%_CPU_usage?=
Date:   Sun, 27 Sep 2020 22:08:45 +0200
MIME-Version: 1.0
Message-ID: <43eeef8e-3a61-4347-a2b8-fd1225dd1703@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
since recently the rk3399-gru-kevin is using 100% CPU.
The offending processes are the kernel threads cros_ec_spi_hig and spi2.
The issue has been narrowed down to
  7222bd603dd2fe607794acd0c53025da1dbde21f
  power: supply: sbs-battery: add PEC support
Kernel version v5.9-rc6 with that single patch reverted works fine.

Regards,
  Vicente.

