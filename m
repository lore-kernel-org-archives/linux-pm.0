From: Ryan <ryanphilips19@googlemail.com>
Subject: Sequence of suspend/resume calls
Date: Mon, 18 Jul 2016 18:34:10 -0700
Message-ID: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33117 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbcGSBeM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 21:34:12 -0400
Received: by mail-qt0-f170.google.com with SMTP id w38so2141159qtb.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2016 18:34:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,


Is it possible for the resume function of a particular driver to be
called before resume function of others are being called?

Suppose, I have a driver - example_suspend, example_resume - Is it
possible for example_suspend to be called last
and example_resume to be called first thing as soon as cpu is woken up?

If so, how can i do that?

Thanks,
ryan
