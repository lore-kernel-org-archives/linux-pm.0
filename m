Return-Path: <SRS0=DtRT=SV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76768C282DA
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D72F2171F
	for <linux-pm@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555702294;
	bh=nivC/OJoYcBD5n0XO9LWE9dXs5Dpb9xLYaK+7342NOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RrgiEc0Nv5H6J3T5NLIYeqUgPXjKYH8CVySJS134GVyaLeBqbP71SlFDh9xQ1NdMD
	 gP1aR37hREBZ0UhLXg5ahgFa528TS1pRLnBf3zVAqlW4b5IfdjRdGUcFxwiFcARU21
	 jrse5HO4NfFyk4DpaEdpMCdl6DYKpScJ/1R0H7Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDSTbd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:31:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53182 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDSTbd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2019 15:31:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so7171285wma.2;
        Fri, 19 Apr 2019 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQSo614gfyQ6AWbD9USBciWn03ozXcVEKq6UIRZvntU=;
        b=gT1REX8N3QN+Gy6qBwdrSK9q2U/fx+aabqZhNZm7PIkpGZPnwpjKafmW4Ma+SO7lXH
         vkZnxQgVsvEJTacSJ+7R7fRC4l8Ya4G3XSLcT5I3taMInZ2Y1DjyZ1R97RklQptTzRty
         gzJl0v+SfEH0wITTg2hG6zIX9OwfBem2kHBG2q1zgbf7VW14LN75FTZaN/wuHjn+xEWZ
         7H4n864NWgF+CLxeyCCGom9IfwlkgDqrMxVm2ncLg6CEVSsIWoXIWrbu9R6/e72+qVZf
         ke/WHSv+b18DUUF42u0zVsVkfkQBGMa3+I3BGCTTc2uCN93evcyt+vkCvRB+6z0TDort
         FZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQSo614gfyQ6AWbD9USBciWn03ozXcVEKq6UIRZvntU=;
        b=VX7XvqGfZLfbnAhph2qBZNx65q12Mt6h784vqkjug/i0gyKsiZPsFGQvMJfCLX210r
         b+UWUHHbFClsdjwURYkeYCuoQIr5+V1O8LJLfXAAoWZJ2Z9bJ2vCljv1aCMJdxZyPnlo
         5mfF5fxZt1WHIIrxFlc56pYSMmbu5mUnfaUPkRpGFPVtgTBbCjRiS3sLT7B4ZBcZC4GO
         Q9fHJfT1mAS17WV1yaqhBpDStQGbd756j9dc1sAIWCqSUF++1RC0fQbKyXS6nDioCH4v
         dsqcMHZCYc9kPv+cozGQZXbdbj5yTEpCLgH7eQBH+PxeVvtbGQ7mxYS7SzuJFD9EXKM3
         JDgQ==
X-Gm-Message-State: APjAAAWddZ8DSXvXH/YiZvHcY/OTexHcTnt7n+Mlp22E3jJ5jmfcNxL6
        tZ6Qfj3m2HNQLVqt5IwUM/a1T0FD
X-Google-Smtp-Source: APXvYqyZGUcMDaiEWSmcNkf2DQcEC/lARkXDKNL5meVRyccMByxNghfZbqzZvfA73ReKVcZL3mj6zQ==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr1720669wmf.125.1555660639687;
        Fri, 19 Apr 2019 00:57:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c10sm3106454wru.83.2019.04.19.00.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:57:18 -0700 (PDT)
Date:   Fri, 19 Apr 2019 09:57:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Message-ID: <20190419075716.GB6795@gmail.com>
References: <20190418144655.18758-1-lkundrak@v3.sk>
 <20190418202000.hcojhcf2f47te44u@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418202000.hcojhcf2f47te44u@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190419075716.Y7I4XDSy6DpNGgJCobaCG2DT6wTnk2Eb6u134I_tF-A@z>


* Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
> 
> On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> > This patch set modifies the OLPC battery driver so that it could eventually
> > be used on an Arm-based OLPC XO 1.75 machine.
> > 
> > Compared to the previous version, it addresses review comments for the
> > x86 platform parts from Thomas Gleixner. Details in individual patches'
> > change logs.
> > 
> > I've failed to version the previous iteration of the set that should've
> > been "v6" for the change logs to make sense. Sorry for that.
> > 
> > Thank you,
> > Lubo
> 
> I queued up the complete patchset via an immutable branch based on
> v5.1-rc1. X86 maintainers can pull this signed immutable branch as
> required. Thanks for the patches,

Would you mind sending these patches to Linus yourself, as part of the 
power-supply tree?

That's where it really belongs, the impact on arch/x86/ was mostly 
drive-by (and it's now all Acked-by Thomas), the meat of the changes is 
in the OLPC battery driver.

Thanks,

	Ingo
