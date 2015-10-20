From: Tim Harvey <tharvey@gateworks.com>
Subject: where in sysfs should I put the ability to power down a board for a
 specific time?
Date: Tue, 20 Oct 2015 08:12:09 -0700
Message-ID: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:32934 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbJTPMJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 11:12:09 -0400
Received: by obbwb3 with SMTP id wb3so16625186obb.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 08:12:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>

Greetings,

There is a system controller [1] on a set of embedded boards I support
that allows disabling the board's primary power supply. It can disable
it (until a physical pushbutton event occurs) and/or disable it for a
certain number of seconds (up to 2^16 seconds).

I've been in the process of writing a mfd driver to fully support this
device and I'm a bit stumped on how to handle the power management
capabilities.

What is the correct API for this type of device in sysfs? I'm thinking
it needs a power-supply class driver, but after looking over the docs
and code I'm not seeing examples of similar devices. Can anyone point
me to an example or provide some suggestions?

Thanks,

Tim

[1] - http://trac.gateworks.com/wiki/gsc

Tim Harvey - Principal Software Engineer
Gateworks Corporation - http://www.gateworks.com/
3026 S. Higuera St. San Luis Obispo CA 93401
805-781-2000
