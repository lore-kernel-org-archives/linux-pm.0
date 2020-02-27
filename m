Return-Path: <SRS0=WjjV=4P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F537C3F2C2
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B4D246A3
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 21:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMG5VflR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgB0V7s (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:59:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45288 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgB0V7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 16:59:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id z5so532175lfd.12
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akb/fqWb9RAKIbbLYDDh8qkuoGYS5G+iOCImBrzoF9o=;
        b=TMG5VflR3I+CGPW+mSXF7fJBlkIgbvu1pHHgkcCLliyNx/65WX4EateAFJ+aYYIZTw
         c3laEpZS9R7qXtce7smYE4n1H0nZi18snVj03jIXMRsHgoFOyMPcwQBWb+g9rcCNCD28
         PdCGEoz3ivKvIuWNhKqTW1465oIKHlXJl+83w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akb/fqWb9RAKIbbLYDDh8qkuoGYS5G+iOCImBrzoF9o=;
        b=Wkjl4Vc2KqT3N1Yi9861nZoLlef8bBlyW3tQMKsG70PTRkuhcDkd33zZzwd5AML02v
         hjhvGBcS8bf7Z3KkFaweoJeIKufK3+fVFeaYciGff2RMAAd0iBRy0agUiTkd9x85+ZnP
         oQE/kBzJ76oQsNN9CVz6VmIHjD75iyAweFWSATt/QVEFRRXbDKA+SKBJOwkCF/s4+Iev
         bgNuE7JTU2YUODnZhM5frzQHEo7TY5CCA5VWc7OysV0ZV/a5UfhxSAjVMuaXHNOGxmcE
         1domj3kjOuiWQGrrAM83vtPA5oHT0zwSmpQDx2OrNZgKiAGxpHKUO55UvZASWNFg8hC6
         gkpA==
X-Gm-Message-State: ANhLgQ1gqQB9sQAtq9xjoffuxt3mWWq0Useyy2x7mag8NHSyhrWy2yf6
        o0awbcKvn44GQcvqmkulUHD9lq1nwKc=
X-Google-Smtp-Source: ADFU+vsbuwDzl860Yya6awLYPIclr19RmXYDKMe4l91CGHG1qt5wXWGN0gDeQl7k6z8hl0Y8HJGh1g==
X-Received: by 2002:a19:4f43:: with SMTP id a3mr780215lfk.6.1582840783403;
        Thu, 27 Feb 2020 13:59:43 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g15sm4179172ljk.8.2020.02.27.13.59.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:59:43 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id w1so989667ljh.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 13:59:42 -0800 (PST)
X-Received: by 2002:a05:651c:1a2:: with SMTP id c2mr734150ljn.79.1582840398185;
 Thu, 27 Feb 2020 13:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-6-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-6-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft755hYH7ue=fv2jvofejoWHZaguji6D-M1qHup-3SJTwQ@mail.gmail.com>
Message-ID: <CAE=gft755hYH7ue=fv2jvofejoWHZaguji6D-M1qHup-3SJTwQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 9, 2020 at 10:35 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
