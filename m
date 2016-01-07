From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/8] pinctrl: convert to use match_string() helper
Date: Thu, 7 Jan 2016 16:19:56 +0100
Message-ID: <CACRpkdai2qxiNLCaH9PFFVs3qu-UycZ2R93g4brYoivRGHzbQw@mail.gmail.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1452168368-75630-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33867 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcAGPT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 10:19:57 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp13so193743745obc.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2016 07:19:56 -0800 (PST)
In-Reply-To: <1452168368-75630-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, Jan 7, 2016 at 1:06 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The new helper returns index of the mathing string in an array. We would use it
> here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Pretty cool ...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
