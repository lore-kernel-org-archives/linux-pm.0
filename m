From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 1/3] fuelgauge: max17042: Do code cleaning to follow
 kernel code convention.
Date: Mon, 23 Dec 2013 18:58:48 -0800
Message-ID: <20131224025848.GG10223@lizard>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
 <1387338834-4046-2-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41903 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab3LXDEE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 22:04:04 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so5937197pbb.23
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2013 19:04:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387338834-4046-2-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, MyungJoo Ham <myungjoo.ham@samsung.com>

On Wed, Dec 18, 2013 at 12:53:52PM +0900, Jonghwa Lee wrote:
> - Remove camel case,

I'd leave this stuff as is. Too much churn.

> - Move #define macros to header file,

I don't see anyone using these definitions outside of the driver, so it
doesn't need to be in its own header file.

I'd drop the patch completely.

Thanks,

Anton
