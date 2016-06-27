From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 0/2] TIF_MEMDIE usage fixlet
Date: Mon, 27 Jun 2016 14:15:17 +0200
Message-ID: <1467029719-17602-1-git-send-email-mhocko@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36398 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbcF0MP3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 08:15:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Miao Xie <miaox@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

Hi,
while I was looking to move TIF_MEMDIE out of the thread info for other purpose
I have noticed these two usages which are not correct. I do not think any of them
warrant a stable backport because it is highly unlikely they would ever hit but
it is better to have them fixed.

I would route them via Andrew unless anybody has anything against.

