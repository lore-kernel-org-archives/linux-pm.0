Return-Path: <SRS0=8pdy=3R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9836AC2D0DB
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC68207FD
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580251666;
	bh=klSBdKKdnRTmi7mTHAVGBUqT7E/n668NU4PR+t2Nl6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OD6KCcaFlOZcR8ktA36X9m24N5CpPvT0Kc35UbGSkpbZJyttpmP7YRNow+BTTIv/z
	 uiWwC2lw0t6Df8AYyVk+v2HEKTH3i9EzhRl7ttfiSy3fkliUDT+2cggh2OPe8TVwJp
	 8MdwvGwWgO77yPsitSmFY7O2dC2dkeZhTOGuYljo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgA1Wrq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:47:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45423 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA1Wrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 17:47:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so13703100otp.12;
        Tue, 28 Jan 2020 14:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klSBdKKdnRTmi7mTHAVGBUqT7E/n668NU4PR+t2Nl6g=;
        b=Cgr1vymJjEmJElzYj/WPju97bIZOC5cDeac9W7xbiqZEtB2RsNon23pxj279fmyMLm
         qRhnZOJZEiuPvZMt8YuEPcjleTr7iNS/oKTT8OOWwcPulusa40ZqLtZIEZuCKndJc2Mg
         HxH372g38i9PYZURcVAUrPyKgdLXtAoEL5Yrp3NcCpv+9JpsYqdmg4xfJYZlmhdTo227
         dpNedYTh9Eqom1FM86EXYz0uWLFwPoDl/fH+l5CNMGsJXUsDKLmHyWCksdoG8NYR2B43
         H18KtSpEBrcYU3JpoZlaX3dhKtKwkcVyjSI8t0+v6PyR5Xr20VEwewryqF7U5ae8jUu7
         n+lQ==
X-Gm-Message-State: APjAAAVoq9njRN4UOwyU+OKEJiIYXarVNvTY28LHx7ji+Sh1fktIaQlD
        5r4S0MXHDEC+AZqaJq7lJ8iLEA0UL+I4Boy5xf6m6w==
X-Google-Smtp-Source: APXvYqyz7fMPx9+EVgqX+4bnisBn7uxQXIsr54CzBkU4mLkCTVihzn9FhbYwfwNR9OqfAt2yx6o50kT2OHH63GmSDc4=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr2334949otl.189.1580251665123;
 Tue, 28 Jan 2020 14:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20200128035957.2577561-1-dsmythies@telus.net>
In-Reply-To: <20200128035957.2577561-1-dsmythies@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 23:47:33 +0100
Message-ID: <CAJZ5v0h2StxrjdohNFzTUFCYZ3ZB7SBnjfaZT9F2gKJhHQ4uKg@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools/power/x86/intel_pstate_tracer: changes for
 pyhton 3 and newer processors
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 28, 2020 at 5:00 AM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> Some distributions are deleting python 3 support.
> A backward compatible minor syntax change is needed for
> use with python 3.
>
> Processors have exceeded some of the fixed y-axis scale maximum values.
> Change them to autoscale the y-axis.
>
> Tested with python 2.7 and 3.7.

Both patches applied as 5.6 material, thanks!
