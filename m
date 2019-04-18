Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE6C282DD
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C4721479
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TxpOoumm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfDRQqN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:46:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37969 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDRQqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 12:46:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so2115871oie.5
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iLiURtyIX3/5eVXfKhiiuM366BsRB2H0v51P1Nra/A=;
        b=TxpOoummUQlpo/zJEelBP5cySuekl2Bck6p/bZvg7Kb2h4F1d2ObbfgBDR9bfK8dPR
         PecA+7tWxuYNrbO+LnhoctRw/eWSIKWi5sDNb0PJPxSw6py/3LgmWX2jPsoo4ys/q7pL
         5//6+wRFTIkWWPja9UXAlhepzoX6/3oUD+OdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iLiURtyIX3/5eVXfKhiiuM366BsRB2H0v51P1Nra/A=;
        b=pWHz7mFbUJ5SU4XrEDS+0j7eH0Y8dHEn9Zegt2Y3eg2KPfTR5/31qSQxUvt4tCG0yk
         ENMDoL/jScKM/Oq52IkL0CXgsD3jTE19B80QSpyYMpijaL7CDhUufjBYlusHGQRqfWrA
         3+sNwOWUCR5bXregssnFqTKPRXAQ4zIVCcbqjiVHmXW5Q+AO+rZuaRjN51TAdqJj8/YP
         /1Plc3fmniNr7Fjh2Of7pJ5apRNEXcnHhfUQq4+lYKq3ytCIgoUERhnxX2KbVVKiwwX5
         Ppylya20i6+5k9v4efaj3ZP3cpMShkqFLbECHfJ9uTsp2d+/NdNZ3WJfnYq5BHcxw1Qj
         yaGQ==
X-Gm-Message-State: APjAAAUSqKZuCl9iKx61xGxremHHlgscYrq6S3xjcir9OTkCzV1wjQmm
        hCZkfGKTpSnAPtD6oXWAmxX1BZbTJ/M=
X-Google-Smtp-Source: APXvYqxC+pc9WChmKeEwk6ELafDLGrgqUy9I3ktslsyNff1BvGrCwEZtovUWcMo4p9EwuTkQwsYk+A==
X-Received: by 2002:aca:3946:: with SMTP id g67mr2818046oia.28.1555605971897;
        Thu, 18 Apr 2019 09:46:11 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id z12sm951362otp.2.2019.04.18.09.46.10
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w139so2100605oie.9
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
X-Received: by 2002:aca:cd95:: with SMTP id d143mr2522433oig.111.1555605970120;
 Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190417004320.232200-1-ncrews@chromium.org> <20190417214022.7jk3usygcpnls3pr@earth.universe>
In-Reply-To: <20190417214022.7jk3usygcpnls3pr@earth.universe>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 18 Apr 2019 10:45:58 -0600
X-Gmail-Original-Message-ID: <CAHX4x85pmo5j1wWLrsNz+nioy-oTwb4NDJcrUKssvdofCmxKug@mail.gmail.com>
Message-ID:
 <CAHX4x85pmo5j1wWLrsNz+nioy-oTwb4NDJcrUKssvdofCmxKug@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] power_supply: Add more charge types and
 CHARGE_CONTROL_* properties
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, jchwong@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190418164558.5wANaZOOL_9mjVwtGY5c80nA6Nxvtfh0JwlnH3WBrKY@z>

On Wed, Apr 17, 2019 at 3:40 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> The changes itself look all good to me, but this does multiple
> things in a single patch, so please split it into multiple commits.

Thanks Sebastian!

I split this into 3 commits:
-add more charge_type's
-add more CHARGE_CONTROL_* properties
-Add missing documentation for other CHARGE_CONTROL_* properties

and just re-sent them.

>
> -- Sebastian
>
