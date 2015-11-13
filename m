From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: "ERROR: "__pm_genpd_add_device" ..... undefined!"
Date: Fri, 13 Nov 2015 20:52:50 +0530
Message-ID: <CANv6ZMbNrzQ75F5q0zCqaTBKFyj-ke0qtghYUYGybJzUDnRCng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36085 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbKMPWv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 10:22:51 -0500
Received: by iofh3 with SMTP id h3so100510877iof.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2015 07:22:50 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

Iam new to power domain (genpd).

Iam trying to use 'pm_genpd_add_device' in x86 driver built as module.
When I compile, I get error :
"ERROR: "__pm_genpd_add_device" ..... undefined!"

Iam trying to add platform devices created using MFD framework to
generic pm domain within my x86 driver.

I see that symbol is not exported.
Can we export the symbol for the above purpose? or am I using it in a
wrong way ?

Regards,
Maruthi
