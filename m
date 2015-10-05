From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeup: wakeup_source_create: use kstrdup_const
Date: Mon, 05 Oct 2015 22:47:31 +0200
Message-ID: <2308863.lX5dfFvLLy@vostro.rjw.lan>
References: <1441834926-14121-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61564 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751115AbbJEUTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 16:19:02 -0400
In-Reply-To: <1441834926-14121-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 09, 2015 11:42:06 PM Rasmus Villemoes wrote:
> Using kstrdup_const allows us to save a little runtime memory (and a
> string copy) in the common case where name is a string literal.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied, thanks!

Rafael

