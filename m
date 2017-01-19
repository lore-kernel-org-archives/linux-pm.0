From: Alexandre Vicenzi <vicenzi.alexandre@gmail.com>
Subject: Kworker with high cpu usage (~80%)
Date: Thu, 19 Jan 2017 00:13:41 -0200
Message-ID: <CAMHH1fXRbWaBv2U2duKF+v6RRcfKLLKkNf=mb0TYA4foj2i5kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35443 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdASCQG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 21:16:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Hello,

It has been a while that I noticed that kworker/0:1 eats a lot of CPU
on my computer, about ~80%.

I never found the real problem, but googling the solution was to
disable some GPE interrupt, in my case it is
/sys/firmware/acpi/interrupts/gpe13.

This is a dirty solution, actually, it hides the problem I think. I
have no idea what is the real problem and I would like to understand
what is.

I'm using kernel 4.9.0-2 now, but it was present on older versions
too. I'm running OpenSuse on a Samsung laptop (Intel i5 3rd gen).

If someone could point me in the right direction I'll be happy to
share more info.

Regards,

Alexandre Vicenzi
