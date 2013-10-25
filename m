From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 1/3] charger-manager : Replace kzalloc to devm_kzalloc
 and remove uneccessary code.
Date: Fri, 25 Oct 2013 16:30:41 -0700
Message-ID: <20131025233041.GB13859@teo>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
 <1382669253-23629-2-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:58628 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab3JYXao (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 19:30:44 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro8so677953pbb.27
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 16:30:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382669253-23629-2-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Fri, Oct 25, 2013 at 11:47:31AM +0900, Jonghwa Lee wrote:
> Use devm function for dynamic memory allocation.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---

1/3 applied, thanks!

Anton
