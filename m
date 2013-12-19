From: Mark Oteiza <mvoteiza@udel.edu>
Subject: PROBLEM: cpuidle: Quickly notice prediction failure for repeat mode
Date: Thu, 19 Dec 2013 14:51:59 -0500
Message-ID: <20131219195159.GB16912@holos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:61178 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab3LSTvC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 14:51:02 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so5160921qac.20
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 11:51:01 -0800 (PST)
Received: from localhost (c-68-55-201-85.hsd1.md.comcast.net. [68.55.201.85])
        by mx.google.com with ESMTPSA id r5sm11388783qaj.13.2013.12.19.11.51.00
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2013 11:51:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Commit 1485191 causes a regression on my hardware (laptop) manifesting
itself as increased power consumption when playing music on mpd using
pulseaudio.

I bisected to find 1485191.  I tested the commit it reverts (69a37bea),
and the commit prior 69a37bea, e34a00d6.  Here's a summary:

  status      sha   power  coretemp
  ---------------------------------
  BAD    14851912     14W       54C
  GOOD   228b3023      9W       47C
  GOOD   69a37bea   ~8.8W       47C
  GOOD   e45a00d6   ~9.3W       47C

I thought it was strange that it happens only with that combination of
audio software, so I was happy to patch out that changeset which was bad
for me.  Past 3.12 (now on 3.12.5), the issue persists and I'm not sure
I can easily merge anymore.

I attached some info I hope will be helpful.

Thanks,

-- 
Mark Oteiza

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii; name="cpuidle.log"
Content-Disposition: attachment; filename="cpuidle.log"
Content-Transfer-Encoding: base64

Pz8fPwY/e2scPyptPz8/P1g/Px0/Pz8cPz9uP3c/Pz8/dT8odT9lPz8iP01pP1seaj9iPz9s
a20/P1seaj9iPwg/P08/P28/Pz95Pz8/Pz90Pz91Pz8/P2c/Pz9dPz8/emptPz8/Pz8uPz8u
alw/P2Y/Pz8/anoldj8/PyonDQo/P2o/Pz8/XnI/P3p7Zj94P2paPz8/P3pnPz8/Pw4/Lj8/
P2o/Pz8/P2p4Hj8/Py4pPz8aJT8/Pz8/QEQhP0g/P0RBDD00Pz83Pz9tdT9NAhE9Pz98fD8/

--gatW/ieO32f1wygP--
