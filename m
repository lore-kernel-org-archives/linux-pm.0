Return-Path: <SRS0=M8qR=6K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7863C54FCB
	for <linux-pm@archiver.kernel.org>; Sun, 26 Apr 2020 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0872074F
	for <linux-pm@archiver.kernel.org>; Sun, 26 Apr 2020 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587909128;
	bh=WOoes9TpUdxs3cMJymtrJPHUPndpSvNYnzPmHiF06HE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HZAn/gOx6EJ1fcK2lAcA6rqBg4UVttD+Mqi+MXLCk/x83MbNzW58qbQMoDeldkt3A
	 FPY/d/0z9K7+38FKeKjK1OXgC5ygwE3I5zPZevdIsBnONpPT5K9advwSucLWbwazdg
	 MrwywjKWzwX8iQq2Fp8wHHMG4k0Qw6iOGAGKsqIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgDZNwI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:52:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34757 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 09:52:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so21472641otu.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Apr 2020 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEdcuwAnoLE6D6a8XrPIToI279K4p4eGNdxTt5+5qq0=;
        b=rIhg5794Ga/eq4fhB1fTYIoYydj6fY8TiGNIy9WuP1FdBweaxNtrFGhODeAeDaNKht
         jalH9x3G0GXh6OLC5g1JopO/Tqb1B6uDQ5rZ5bHlC7tm4002+m7NF29ce2VUs4VL9pTG
         UG6Lvf9kLha1e6xdFQI5GkNiyTIrW+l0zyX9AsCvPV2Ig2zt7dn4VGeeJlYlTuSHrDMA
         yVFtb7gpJotub/zUxsOdU2NCS6EUmoFBWtnRjsbPWL7k6mxbLDYnjeplzQV7Yz/CuZnN
         Q/v7hLwybdsNJm/QGg30kj3x7BodttQyejkfElKqrY2ns7Abk2//NiaLMDhBytvte/zs
         INKw==
X-Gm-Message-State: AGi0PuZJzNvZh/sujlMhjhyWXFUarG60fiUhYCx5kFHug/NSfCIgllmg
        620uxwtMhuopcNF5/Jv3W21G3o6662GHtoFZX/RSqA==
X-Google-Smtp-Source: APiQypLYoc+nbtMKcEM6cdBh+ooILQYoyBAQ8ppseIgfNwoF05zwIugc7S84E7VcPVSPCXwJBYYAW9RKPX12KlW7Y6c=
X-Received: by 2002:a05:6830:18d0:: with SMTP id v16mr14433310ote.118.1587909127281;
 Sun, 26 Apr 2020 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.2004251632340.4125-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004251632340.4125-100000@netrider.rowland.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 26 Apr 2020 15:51:56 +0200
Message-ID: <CAJZ5v0jr-EsEHxuwGDo5sFg0K6MWzLmp_Vr0YzX_YLo9mdK2QQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Helpful edits for devices.rst documentation
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Apr 25, 2020 at 10:35 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Here are some minor edits of the devices.rst documentation file,
> intended to improve the clarity and add a couple of missing details.
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>
> ---
>
> Rafael, here are the edits promised earlier.  Hopefully you will agree
> they are an improvement.

Yup, I've queued up this patch for 5.8, thanks!
