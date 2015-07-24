From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 14:17:05 +0200
Message-ID: <CAH6sp9MXP2=naPtovJTrTAm9SgGcG5qZQs+ee34YPQ4t1mbi0w@mail.gmail.com>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:32889 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbGXMRG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 08:17:06 -0400
In-Reply-To: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Fri, Jul 24, 2015 at 1:58 PM, Vaishali Thakkar
<vthakkar1994@gmail.com> wrote:
> Use devm_kasprintf instead of kasprintf. Also, remove various
> gotos by direct returns and drop unneeded label err_free_name.

If there's to be a respin, reword this so that it becomes clearer that
removing the various gotos and the label is an effect of using
devm_kasprintf here. I started out thinking that this patch did two
things.

Frans
