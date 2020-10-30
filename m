Return-Path: <SRS0=aTLV=EF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E3C00A89
	for <linux-pm@archiver.kernel.org>; Fri, 30 Oct 2020 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B47C20727
	for <linux-pm@archiver.kernel.org>; Fri, 30 Oct 2020 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604076398;
	bh=x3h1za4GlDp9JpJB/OhLNF3JbpPhEHysgPvAh+Sbiko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RQDeL6ENJIxWqicK+KarVC8TwmD2Rty6cbBo9S0DpFHVyDqa+fJh6Xs2KqCD129UU
	 MLYjA33hA59r908h/55HGwdSaKLp3Z4rhqaye/2wzl2zGmIkz+9Pa5bwzYJsa0jE0B
	 XJSzDZQY1I3mwuamJsNcgEDpukuDN6YvMOlvbeCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3Qqi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:46:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44171 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJ3Qqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 12:46:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id m26so6076010otk.11;
        Fri, 30 Oct 2020 09:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdHn4Bghzba5wOelTeZ6mhUplKqje06p67vbKsYURC0=;
        b=cFMBnFtwUKvmqXAdDDDbjD190ZucouS1+crWbSRnVgI3b/fHLOvFIW4kudTNuZ1TW+
         zH4gB56F4bOiD3duQX0L08rd86k0PoOjL2JrJtYVtz+BYQPWbZsM33gEYUYqh70oKFn7
         p7TkqXxq+9h/8B3w38mBNt64C7pf2++2t863VEkFa7RbEFV3w0jW4y38q/D4n5iYj9bv
         lfH50ltOEzuactU0zTXgNuFR2Bi0KqA7hxo7b1ZdUib+UZajdFvz/CXD2wZImdaYSgYx
         e0SMI+cmoHlg5Sgg1Ow+37TZDuwlTGdQ9rVqtya3uHBAk+P5PKq+wpvkqMzyfJMdAr/m
         APtw==
X-Gm-Message-State: AOAM532jN4UOomxjj8K/3WXDwcUWkFsJt+gwR0Iphposk5a0N9X1pJ8x
        dHt7FIR/ftxTeE6sitK4vQbbEgCf0MAEAjGhFuFCXReXie4=
X-Google-Smtp-Source: ABdhPJxQnyAvlfHtIgYhFfMOUC6BuhMQiwnFHpToclGQhxGMD4Ajfu4gnrgfD0oPO2jq5IWpmVzD470Ajv8wMlhEutc=
X-Received: by 2002:a4a:e80b:: with SMTP id b11mr2575066oob.1.1604075920719;
 Fri, 30 Oct 2020 09:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <6543936.FbWAdBN1tG@kreacher>
In-Reply-To: <6543936.FbWAdBN1tG@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 17:38:29 +0100
Message-ID: <CAJZ5v0hRMcsdGVOHCfeK4_k81L+PJSNq80kx1BpwDBs+WtgqpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: runtime: Fixes related to device links management
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

On Wed, Oct 21, 2020 at 9:14 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Greg & all,
>
> Commit d12544fb2aa9 ("PM: runtime: Remove link state checks in
> rpm_get/put_supplier()") merged recently introduced a weakness
> in the handling of device links in the runtime PM framework that
> may be confusing and even harmful.
>
> Namely, the checks removed by that commit prevented PM-runtime from
> getting or dropping references to the supplier device whose driver
> was going away via its links to consumers, which specifically allowed
> the pm_runtime_clean_up_links() called from __device_release_driver()
> to run without interfering with runtime suspend/resume of consumer
> devices (which still might happen even though the drivers had been
> unbound from them by that time).
>
> After the above commit, calling pm_runtime_clean_up_links() from
> __device_release_driver() makes a little sense and it may be interfering
> destructively with regular PM-runtime suspend/resume control flows, so
> it needs to be either fixed or dropped altogether.  I prefer the latter,
> because among other things this removes an arbitrary difference in the
> handling of managed device links with respect to the stateless ones,
> so patch [2/3] is doing just that.
>
> However, in some rare cases pm_runtime_clean_up_links() may help to clean
> up leftover PM-runtime references, so if that function goes away, they
> need to be cleaned up elsewhere.  That's why patch [1/3] modifies
> __device_link_del() to drop them upon device link removal (which also
> needs to be done for stateless device links and that's why I'm regarding
> this patch as a fix).
>
> Finally, to avoid pointless overhead related to suspending and resuming
> the target device for multiple times in a row in __device_release_driver(),
> it is better to resume it upfront before checking its links to consumers,
> which is done by patch [3/3].
>
> While this series touches the driver core, it really is mostly related to
> runtime PM, so I can apply it if that's OK.

Any concerns regarding this series?

If not, I'd like to queue it up for -rc3, because the current behavior
in there is quite confusing (or worse).

Cheers!
