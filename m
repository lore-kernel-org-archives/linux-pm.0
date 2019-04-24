Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A0C282E1
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 05:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EA7218D2
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 05:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="yWRcxS73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDXFpS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:45:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37252 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfDXFpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 01:45:18 -0400
Received: by mail-vk1-f196.google.com with SMTP id o187so3753341vkg.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0Wc5BL5b8FQMAhj5aGLDV5qkvNFpBbJ01FIXU1V+5U=;
        b=yWRcxS73zxuRuB4oqXAy891+GIvyi9/WMvnmeLlzpFcVSYOEQoTVtT0VjZW8LdlDC6
         6wL+rd293kllQ6lWI9SHZROoEkCaCCxKmjxP5MFq+qZvQBEii5N5lXIromh0krFzjERf
         qMQTaqJVRRDrxqGA5+JZYMwvnlNvZbDR2y5cGaqxQGN41e7Iu+4vMXqddtSlSbpC5JyD
         rYsRtQET8JeKgbrBlMYMA4ypGrOmPSwtRJOFHgP2TeWakWnjjWtipk0Siec7UUp4JATr
         6EWDuLbnzhrkSxVsilSD6OEoHaglAtTk6iP/WBOGHxQUQtr1LXtTwJp1tHx/1biHvBnR
         897w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0Wc5BL5b8FQMAhj5aGLDV5qkvNFpBbJ01FIXU1V+5U=;
        b=MkscdRs+aeHPMpFoyiUsNgjH2z5k9cTIYIpUws0R7i632XTbnrcst1ZcijN90KypdA
         AabOWo8rI9ee6sZ29su2capLab5WGb626Z2oVVt61q9KrbxJJ+qP/C1m5YBhu7shA2D4
         5eACiX9MPjwRpmLXvKivNPlbK5B8vNlaiQSuD+Go+6yidh+mQfMw7bXA3e3sYf/cHy3Q
         ymUXFC4v0cRy+xZaPMPGeyDr6GELOWy/Kx2wsw7A/ANZilyy1gMiFMNy1wf6InHkSc7l
         ey2HMW3Y1BbUPw/lob+MQX+7U4HDE0dwBg8C+31IxIwpEcb/UIVPDvEVVzSQ2T7oD4ul
         xymA==
X-Gm-Message-State: APjAAAUebiPa5aRIfjLJxsihdpLxipiyoPylGhEllA5JiqZuLdiEzatz
        Cwx54McY49DCr+S7Fgeiv6cb7PVHNYKFT3xK1wrApg==
X-Google-Smtp-Source: APXvYqx9WmkjDeXL4lrzhJTbqSxeqLK6D7+QFGP+BnZpaiXEVFQAP6ZsqphCfMF2FIXMivCKcgpcPAxFPp4KlU7jAHM=
X-Received: by 2002:a1f:812:: with SMTP id 18mr377332vki.68.1556084716748;
 Tue, 23 Apr 2019 22:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190423155208.GC16014@localhost.localdomain>
In-Reply-To: <20190423155208.GC16014@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 24 Apr 2019 11:15:05 +0530
Message-ID:
 <CAHLCerOs-8pAZFvEpxc-ktNV631LaLEmjCyObsYKKC0U29kLag@mail.gmail.com>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's option
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424054505.fl7lQjyFtuqpfG-7PeQMvZqPXlvx60gfsgf1wNxF5cs@z>

On Tue, Apr 23, 2019 at 9:22 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hello,
>
> On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> > The module support for the thermal subsystem makes little sense:
> >  - some subsystems relying on it are not modules, thus forcing the
> >    framework to be compiled in
> >  - it is compiled in for almost every configs, the remaining ones
> >    are a few platforms where I don't see why we can not switch the thermal
> >    to 'y'. The drivers can stay in tristate.
> >  - platforms need the thermal to be ready as soon as possible at boot time
> >    in order to mitigate
> >
> > Usually the subsystems framework are compiled-in and the plugs are as module.
> >
> > Remove the module option. The removal of the module related dead code will
> > come after this patch gets in or is acked.
>
>
> I remember some buzilla entry around this some time back.
>
> Rui, do you remember why you made this to be module?
>
> I dont have strong opinion here, but I would like to see
> a better description why we are going this direction rather
> than "most people dont use it as module". Was there any particular
> specific technical motivation?

Speaking for Qualcomm platforms, we want the thermal subsystem
available as soon as possible for boot time thermal mitigation since
faster boot times equals hotter cpus. Also the dependency on cpufreq
subsystem due to the cpufreq cooling device would be simplified with
this.

In fact, I now have a follow on patch to move thermal init earlier
than fs_initcall since we'd now not wait on modules to be available.

/Amit
