From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2 v2] speeding up cpu_up()
Date: Fri,  8 May 2015 02:37:53 -0400
Message-ID: <1431067075-11449-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:40734 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbEHGiR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:38:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for testing, Aravind, Borislav,

I went with Ingo's suggestion to made this a quirk.
However, I went with a white-list instead of a black-list,
because fewer comparisons are needed for modern processors.
Families are added infrequently, and finally, we get the option
to stick something other than 0 in the table if it we need to.

Let me know if I got the AMD family #'s right.

thanks,
-Len Brown, Intel Open Source Technology Center

