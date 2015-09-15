From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: align wakeup_sources format
Date: Tue, 15 Sep 2015 13:19:15 +0200
Message-ID: <20150915111915.GB32689@amd>
References: <1439542767-689-1-git-send-email-check.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41890 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbIOLTS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 07:19:18 -0400
Content-Disposition: inline
In-Reply-To: <1439542767-689-1-git-send-email-check.kernel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: check.kernel@gmail.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Ethan du <duhui@xiaomi.com>, Linghua Gu <gulinghua@xiaomi.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yangdongdong <yangdongdong@xiaomi.com>

On Fri 2015-08-14 16:59:27, check.kernel@gmail.com wrote:
> From: yangdongdong <yangdongdong@xiaomi.com>
> 
> This aligns every column of elements in wakeup_sources to
> conveniently check any specific column for suspicious power
> consumption wakeup source or for other easily readable purpose.
> 
> Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
> Signed-off-by: Linghua Gu <gulinghua@xiaomi.com>
> ---
>  drivers/base/power/wakeup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Its debugfs, so format update should be ok.

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
