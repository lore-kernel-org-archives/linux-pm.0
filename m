Return-Path: <SRS0=MHso=B7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4BC433E1
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1428C20720
	for <linux-pm@archiver.kernel.org>; Fri, 21 Aug 2020 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598034220;
	bh=YjnGtgZAm8NmNttOCU7qoNtT1I0OZTLn5sfxamogPXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KbfjPV0F8u+i0x0IZr7PrcJ20yA1RZv66PwW/2erJcjaL486sg83sm3OGMAj7WoS3
	 CeyRBY4h4+egYO+Hmch3AW+9sNuNY/tUEJSl+/ORf2jB6/hK35LYpi/j3i/2A79sP/
	 lbJsElonAgPWRnkvlSTxUcbq3S9PtfKUR03xomn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgHUSXj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:23:39 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44428 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHUSXi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:23:38 -0400
Received: by mail-ej1-f66.google.com with SMTP id bo3so3370593ejb.11;
        Fri, 21 Aug 2020 11:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ik24Pn50+AFSzC/zSLjdolgrHNOwiWrGKLY+tyLf6y0=;
        b=U3uAWmAM8cM9zKJNmyPNPB1xStNLANuE/X+x2cdKaLZxri4cj169hCQx+BOJS9sa0p
         bLCReuCX8x1hQTXz6aG1zcSG9bYAzbJb+6yHzxhx5U8zyHAxzCXUsPuJWNa0T6wXLwbz
         1rytH7gDJoAmj8TqsKqlF73PekWP/IgK/4yfAoLF5pwhEOaMw0fokRh3ZAmBLQyZ5VN5
         RTEm8g5NkP5bM9HsNp38Qv7VuX2s4Z+q5s4zCJyJDlvSacCOciiHaELmpkx5Pt/olEmN
         j9vi34w1Nfx+b6FfGosoNSYtTBsFyUrJXVfU3Gxoje+gUowetatZDdmDWLZP08w02bYy
         31dw==
X-Gm-Message-State: AOAM5307UYjhf36sNr9NWMn9PyiDJu6BlQMyj8o1ojYwCLAIfOA4Qh3u
        ugB6Jqt49X1CDGo7Q9m59DoGgJrYOybk8lOoA6y8JwJ2
X-Google-Smtp-Source: ABdhPJyfhHKvLdCjmom4XAojkrgk5ZNIN1FBTEoRjtkk3wCieNVVu/zuLSNK2hdo6lUDcZgllT3qR8arxEDagQfDrJw=
X-Received: by 2002:a17:906:a219:: with SMTP id r25mr4211610ejy.201.1598034216965;
 Fri, 21 Aug 2020 11:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200810144330.75613-1-darcari@redhat.com>
In-Reply-To: <20200810144330.75613-1-darcari@redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:23:25 -0400
Message-ID: <CAJvTdKms-sO=Qvpnhe4OjE48gXHPzDKbT0i5vK2QuDCxZTt_+Q@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: fix output formatting for ACPI CST enumeration
To:     David Arcari <darcari@redhat.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dave,

I think this is fine.
Indeed, I actually went ahead and applied it a week or so ago.

the only alternative that I can think of is actually shortening the
ACPI C-state names in the intel_idle driver -- which is still an
option.  It would not be the first time we have tweaked the names used
in that driver to make tools more happy...

My apology for neglecting to send you an ACK.
I had intended to send my queued series to the list, which would
suffice for all the ACKs, but that send and the subsequent push got
delayed by this and that.  So I'll try to ack as I go, so it is clear
at any time where a patch stands.

thanks!

Len Brown, Intel Open Source Technology Center
