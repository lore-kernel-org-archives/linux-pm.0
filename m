From: Michael Tokarev <mjt@tls.msk.ru>
Subject: resume from hibernation without touching saved image?
Date: Fri, 31 Oct 2014 15:00:26 +0300
Message-ID: <545379DA.8070701@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:33573 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757934AbaJaMA2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Oct 2014 08:00:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello again.

Currently, linux kernel is able to resume from a previously saved
image, and it basically clears up that image when done, so there's
no way to resume from it once more.

Is it possible to _not_ touch the image at all and keep it in the
same state as before?  Maybe putting it to a readonly block device
(like blockdev --setro, or mdadm readonly array) will help?

What I'm thinking is to speed up starting of a diskless client which
boots out of read-only filesystem - the only thing it needs to do is
to start X server and connect to a terminal server, but booting it
to the point when it can do that requires some time.  So I'm thinking
about booting it there and suspending it, so it can be resumed later,
so the only thing left is just to start X.  That works, but the prob
is that it works only once.

So, basically, how to turn off that feature which resets the saved
hibernation image at the end of resume process?

Thanks,

/mjt
