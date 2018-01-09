From: Samuel Morris <samorris@lexmark.com>
Subject: question: concerning disabling suspend of individual devices
Date: Tue, 9 Jan 2018 16:28:45 -0500
Message-ID: <CAFY_6qoHuBUJ=SqWGKLb=QRm+RqQ0sY_LYiT4h-5Yi1HXz=LZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45543 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeAIV30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 16:29:26 -0500
Received: by mail-qt0-f176.google.com with SMTP id g10so19607292qtj.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 13:29:26 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

Unless I am mistaken, there does not seem to be a way to disable system suspend
of an individual device, either through sysfs or a probe time config. I've
encountered cases in the past where either the suspend behavior of a device is
buggy, or functionally it just does not do what I want. For example, I had an
led I wanted to keep on during system suspend. Nearly all LED class devices turn
off during suspend, and offer userspace no method of preventing that. This
doesn't seem like a quality of service thing, the led just does not have the
suspend behavior I want. I am in the process of making that particular case
configurable, but why not just add the option to disable suspend for each
individual device as with runtime_pm?  Would this be a worthwhile feature to
work on?

thanks,
Sam
