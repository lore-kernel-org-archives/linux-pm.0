From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v3 RESEND 0/2] Update charger manager driver to support
 device tree
Date: Mon, 23 Dec 2013 17:12:11 -0800
Message-ID: <20131224011211.GA7915@lizard>
References: <1387348955-23174-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43763 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402Ab3LXBR3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 20:17:29 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so5902220pbb.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2013 17:17:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387348955-23174-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org

On Wed, Dec 18, 2013 at 03:42:33PM +0900, Jonghwa Lee wrote:
> Until now, charger manager doesn't support DT at all. It only works with
> legacy platform data. Therefore, charger_desc structure which is requisite
> data for working contains non-friendly variables for DT, as like funtion ptr,
> and u64 type data.
> 
> These patches modifies charger_desc structure and driver to support device tree
> fully. For using device tree in charger manager, you can check example of
> charger manager's device tree model in Documentaion directory.
> 
> Currently, there're many required nodes for proper charger manager's
> working, we would optimize them later.

Applied, thanks!

Anton
