From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 0/3] thermal: fix: Various fixes for thermal subsystem
Date: Thu, 02 Oct 2014 16:40:35 +0200
Message-ID: <20141002164035.1133b66f@amdc2363>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37802 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbaJBOkm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 10:40:42 -0400
In-reply-to: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

Dear Eduardo, Zhang,

> This little patch series comprises fixes for step_wise governor and
> thermal core.
> 
> Lukasz Majewski (3):
>   thermal: step_wise: fix: Prevent from binary overflow when trend is
>     dropping
>   thermal: core: fix: Initialize the max_state variable to 0
>   thermal: core: fix: Check return code of the ->get_max_state()
>     callback
> 

ping.

Please note, that those are rather self explanatory fixes.

>  drivers/thermal/step_wise.c    | 2 +-
>  drivers/thermal/thermal_core.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
