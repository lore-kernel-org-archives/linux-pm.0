From: Ran Shalit <ranshalit@gmail.com>
Subject: External devices
Date: Tue, 2 Sep 2014 17:46:44 +0300
Message-ID: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58154 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaIBOqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 10:46:45 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so6432823qaj.35
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2014 07:46:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I am new in the subject of PM, and though been trying to delve into it
and reading, I still see it is hugh subject and still have many
unresolved questions.
I hope you can help me with some of them:

1. Are external devices can be integrated into the runtime
suspend/resume , or are they outside the subject of PM ? for example I
have external dsp connected to omap, can it be integrated to the PM ?
If it is controled through character device how can it be tailored
into the generic PM ?
2. When the system moves to idle does it then automatically call all
tuntime suspend of all devices ?

Thanks very much,
Ran
