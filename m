From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] power: max17040: use devm_kzalloc
Date: Sun, 6 Jan 2013 14:21:43 -0800
Message-ID: <20130106222143.GG26928@lizard.sbx05280.losalca.wayport.net>
References: <1357448005-20896-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50989 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3AFWZN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jan 2013 17:25:13 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so10213039pbb.10
        for <linux-pm@vger.kernel.org>; Sun, 06 Jan 2013 14:25:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357448005-20896-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Sat, Jan 05, 2013 at 11:53:25PM -0500, Devendra Naga wrote:
> use devm_kzalloc and no need of error path and unload frees
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> ---

Applied, thanks.
