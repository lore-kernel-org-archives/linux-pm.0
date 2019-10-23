Return-Path: <SRS0=tW8b=YQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEDECA9EB6
	for <linux-pm@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17FD2084C
	for <linux-pm@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571819612;
	bh=D4gOnQeLuj9+5il4ltBSis3rRpxk4R0QCuWQA3A0S4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wh6W76KXTsh0h8Y7SA9zC3lAUBq2tcdhqPHSw4WgoW3KWxNPanx2Kf66mKbNO9X/X
	 Jb5BmmnXQ2sMqXaBV+NsixLzTMfzxhGc36E0Y6nrEwU7nr8RmQaJoiKBBSK74VD8nG
	 fNOfgwkJW0rnH/qpvkKt5MUQw4pR7sWZvWQEbx+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfJWIdb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:33:31 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44772 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJWIdb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 04:33:31 -0400
Received: by mail-ot1-f51.google.com with SMTP id n48so1750153ota.11
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfyLsyouTrLcWvGpDw8Mc60JVri63iB7UVRISL3VHjg=;
        b=qFP1PXvKxt7QFUDJz2YOua9oGWlgQlOeBnfpnZwHDaZs7bJvY6wOh4M+ghoOI59vVE
         BCj0FGt3k8KL4HXma8AnwL6ME0QTd16YnZrDCZWpBLEURaBnoE25mZgfUlS1uOFLNAEb
         aOm42qz5qAeJ8nyQwAPVj4+uE6EjYzPry2zC9p7olkvrDOOM9tSidt7ebym+bPrsZJgp
         E8Xehe2fkeoeJGemEtkDGkWewRCukmFa4syrZVWQ4BI23kQC/qHeqPUVf1dQ6HzM6jQ+
         NobcVpjZ1fCt/Fz4En8sbwILocK8Rtn1LU9kzs3LYJ4nlVAhAsLHKGrN2zEJYh9RPa13
         D4fw==
X-Gm-Message-State: APjAAAUJ7EvJ6Sa3Fws0h1Ez/YMvZKZDhQBLYSKAuAQs3hr1D8shJkTA
        3CswfntjLrIktDcp+Ppr2BcsR7hLqm0xIxYHsUGA+g==
X-Google-Smtp-Source: APXvYqwmMjrhnMTSvX4IsUC4ZA84B5OI6iwEnQPe/rr+xi/HLA7k2tJ2f2GO3Qx5wN6bcQQmQ4mVC+VT9gKP6bCxeZw=
X-Received: by 2002:a9d:664:: with SMTP id 91mr6106462otn.189.1571819610469;
 Wed, 23 Oct 2019 01:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191023053517.aa7not4zqjt5tvtw@vireshk-i7>
In-Reply-To: <20191023053517.aa7not4zqjt5tvtw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 10:33:19 +0200
Message-ID: <CAJZ5v0gsewEsAjcvJbwB7cocH9XO1_PSmBZGiExUx8P09YSsYQ@mail.gmail.com>
Subject: Re: [GIT PULL] opp/fixes for 5.4-rc
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 7:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Patch to revert addition of regulator enable/disable in OPP core
>   (Marek).
> - Remove incorrect lockdep assert (Viresh).
> - Fix a kref counting issue (Viresh).

Pulled, thanks!
