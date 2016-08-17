From: yoma sophian <sophian.yoma@gmail.com>
Subject: how to enable suspend to ram for arm-64 bits
Date: Thu, 18 Aug 2016 01:26:14 +0800
Message-ID: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35388 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbcHQR0P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2016 13:26:15 -0400
Received: by mail-it0-f68.google.com with SMTP id f6so10138271ith.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2016 10:26:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

hi all:
After I finish porting aarch64 linux kernel on my platform and enable
CONFIG_PM and CONFIG_SUSPEND,  I found there is no output when I cat
/sys/power/state.

After tracing kernel code, kernel/power/suspend.c, it seems we need to
create global suspend method table with suspend_set_ops then we can
get valid pm_states.
Is any dts or place like arm/match-xxx for registering global suspend method?

appreciate your kind help in advance,
