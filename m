Return-Path: <SRS0=539E=7W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F2AC433E0
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB0F20774
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itb2uLnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgFIRgY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgFIRgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 13:36:23 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0EC05BD1E;
        Tue,  9 Jun 2020 10:36:22 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y123so12533864vsb.6;
        Tue, 09 Jun 2020 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+hfc168tUC+zhE7HdDbSPvhxjLmLqzpSRuwOiO02lUo=;
        b=itb2uLncUa38xuwzhKPG/cAifugxmQadT0b48g7STne0gbk3dYlJLHyvrrgArOoE+g
         qN5+xW0Sy643o1KJ42gsdooR6Kfk1UaeFE0DFm2TK5OEidPfa0gec1D42Pq2kI2linJe
         lBnS80uFIDJlutSoSyBgy99oynDCbR+nV1NObnIE29IOfr8Q3f48pQD4E4HD+IY7fmBR
         3eGYJJqr7Faqyo7a2X/Pk38PXkCl/uBYBcv7+L7UaTQghus1ROrWYJ1Rf+aioPB3joJX
         /pQeFm+RLm+MzAdDsRRYg2LKGBFsEG16IyGPUqE8q8YutEupgk7FgqD/O+FNqWXtlFOW
         g0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+hfc168tUC+zhE7HdDbSPvhxjLmLqzpSRuwOiO02lUo=;
        b=RhTMH9d1zctADiEXliGpCIrf68kXSzf9kkv77Irxkqom3EQ1PLOQvcACu1rDWdBW+b
         aqnBiCVRvfxv1OTd3S9HzPJZo1hB+4x8EGmW73YT6R+T8mP9LxUN2fb/OE5D2K8UAe4r
         DJJn200DKSVmbd9XEykE1H928DXWDJLwHi9Lw5OZps0f4mYdIZUrRzRzg8jV/g7qr7Gr
         8RB9lu5/I4uHw6iIN7fFLrZuHkGfjrL4OQGS6b7PVEYamgQXzBF+LmHGtzNfn4n1e3vj
         QFdpgTtqZrDLv5diX137E27/BzHOmwBJUMUYWne8riObiJ1Jxz6QBe5ah0OAjCJJdPxl
         4Tcw==
X-Gm-Message-State: AOAM5323G70U7OQw4nrkVk2oBQXTxHU2wwW1MMXOyUFwpk3jrw5o4493
        i3RFwRwRjHTWPrD8waFXFwwD0mUpKku1As5Cy+8Sbf2q
X-Google-Smtp-Source: ABdhPJw/2fTGJwqklKkrDcB2UArjf16hmbr6TKwovs2+xdL81BE0n7Ouu4tJufHdu+KSm0ZrX2s861SskYQXto5PLDc=
X-Received: by 2002:a05:6102:20c8:: with SMTP id i8mr4861338vsr.106.1591724181524;
 Tue, 09 Jun 2020 10:36:21 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 9 Jun 2020 23:06:10 +0530
Message-ID: <CAOuPNLj4m_jvs90YpAq5r4gAP9o8Y1Uck3HN+MbsTPb3zP=4eA@mail.gmail.com>
Subject: Generic way for verifying GPIO wakeup capability
To:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org,
        zonque@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I am looking for ways to wakeup any devices (from sleep) using any
arbitrary gpio wakeup method in a generic way (either from user space
or kernel space) that should work on any kernel version (starting from
4.14 onwards).

What are the options available right now ?
I wanted to experiment with all of them and decide which is best for us.

Is /sys/class/gpio/ method still valid with the latest kernel ?
Or is there any other method to do it from user space ?

One option I know is to use enable/disable_irq_wake() API from kernel
driver suspend/resume path.
Just like this:
https://lwn.net/Articles/569027/

But this requires an additional kernel driver and device-tree changes
for each gpio wakeup, which the end-user needs to implement on their
own.

Is there any other existing generic mechanism?


Thanks,
Pintu
