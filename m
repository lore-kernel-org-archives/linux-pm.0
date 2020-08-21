Return-Path: <SRS0=MHso=B7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E884C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 18:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07C52075E
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598033577;
	bh=gkxu0l1FDB0fNKXRa7l7mAwt5dC9vA3jIO/hZyVVjR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tX3epFS8imUO7OF6Wg7uT90Kdiix2D4BN3SbkzNNeEP+QF+2rIfAJVex6egMyveqG
	 P0r6xmbY5SS92Hbp/mYWNZyJ9ih2C74ePX2t4LZJ2kkgLH8ZGGfxvpxkQ+cPMqG0IB
	 eMOQMHiACl5zKk3WlGiDuQMkyHY0H+zVEOcDF590=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHUSM5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:12:57 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40633 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:12:56 -0400
Received: by mail-ej1-f68.google.com with SMTP id o18so3346607eje.7;
        Fri, 21 Aug 2020 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkxu0l1FDB0fNKXRa7l7mAwt5dC9vA3jIO/hZyVVjR0=;
        b=A5UFobK656ReMK15SfuP/BNkIGNYxnHObi/l+9rj68cxBUQbfyQVi4DcOo9MB9piyM
         nx/PIso8wUoF3b/5D4xOlsH8acqrvaom+jGbPwvBQf/DXwA4Hou8vviIzw3ZqabRwYWt
         8kHlLc0IrZKBnN7xWJ9TjNhgIEj0XwEnH0HniODj1VoBlny5OTB3qS+Bn6yw8lkR6gW5
         H7S9zvnakK/nLsvKlr+kwMP8YKs1zdk7ZdGpt/XARpKr6tfMJHA5axbqh3GgecCqcl3D
         O4m2rcgI1P79gMbilTdzRMdzwKDuuzYdMbjm0VAlHuV3Sj8qZXoo2vKLyNuSKS/2wdbT
         mbaA==
X-Gm-Message-State: AOAM533dzHrSgbhJzk8z7ty3pdL89bkaQhSXJoJshzl28Jd7WWHAsgx0
        gDJksTxxjlS8PLB+84ME/jJjrkxl7n6BQvxg+VE=
X-Google-Smtp-Source: ABdhPJxaXo7qfCNNAYhs2JJ5QB4yXhur6Plu3NWRJjXSSr6sSpf/I4hI5lzbhJWkfhDRUQIcHXku1wkkDsZ6eetSvR0=
X-Received: by 2002:a17:907:385:: with SMTP id ss5mr3976698ejb.496.1598033574493;
 Fri, 21 Aug 2020 11:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200817083223.18697-1-yu.c.chen@intel.com>
In-Reply-To: <20200817083223.18697-1-yu.c.chen@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:12:43 -0400
Message-ID: <CAJvTdK=8rMpr8_WMWUn=NGcvBOjAdf-AiROkVM596xUtz6LRcw@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Support Sapphire Rapids
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Already have this one.

thanks!

Len Brown, Intel Open Source Technology Center
