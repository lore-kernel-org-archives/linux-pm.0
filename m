From: Ran Shalit <ranshalit@gmail.com>
Subject: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 20:26:48 +0300
Message-ID: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:56644 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaIJR0s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 13:26:48 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so9596414qgd.29
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 10:26:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

Hello,

What is usually the criterion for PM (power management) suspending
that application shall use ? Is it according to minimum threshold for
cpu load (as indication for no process) ?

How usually it is performed, i.e.  is it some periodic process, which
wakes up periodically to check criterion for cpu load ? If so, isn't
it problematic in PM terms, becuase it mean that the system is resumed
periodically (as a result of the the periodic timer's interrupt), and
all devices are resumed ?

Thanks,
Ran
