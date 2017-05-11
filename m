From: Ryan <ryanphilips19@googlemail.com>
Subject: low capacity signalling
Date: Thu, 11 May 2017 20:55:21 +0530
Message-ID: <CANMsd00fsbaDwZkBVGcigPfdyOhP-F2Y3Q0ggCqS+pFy6+iy9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35420 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756253AbdEKPZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 11:25:22 -0400
Received: by mail-qk0-f172.google.com with SMTP id a72so25274774qkj.2
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2017 08:25:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I want to write a Linux Application which shutdowns the system using
poweroff command when the battery capacity is around 10%.

How can the battery monitor chip signal to the application.

I want to avoid polling. How can a driver implement such a feature in
an optimised way.

Thanks for your help.
ryan
