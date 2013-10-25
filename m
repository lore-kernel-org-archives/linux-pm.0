From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] fuelguage: max17042: Support regmap to access device's
 registers.
Date: Fri, 25 Oct 2013 16:55:08 -0700
Message-ID: <20131025235508.GA19447@teo>
References: <1382676902-28077-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38082 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab3JYXzL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 19:55:11 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5826846pdi.5
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 16:55:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382676902-28077-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Fri, Oct 25, 2013 at 01:55:02PM +0900, Jonghwa Lee wrote:
> This patch makes max17042 fuelguage driver uses regmap API to access
> its device's registers.
> 
> It's based on linux-next.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---

Applied, thanks!

Anton
