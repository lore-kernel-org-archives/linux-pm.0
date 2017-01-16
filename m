From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 6/6] power: bq24190_charger: Handle fault before
 status on interrupt
Date: Mon, 16 Jan 2017 11:57:24 -0700
Message-ID: <20170116185724.GG27262@animalcreek.com>
References: <CAKvHMgTmO6M9sWM_hSxQYoNLzmbZmhJ2uG--vSecrG=ko6ugwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55678 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751089AbdAPS50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 13:57:26 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgTmO6M9sWM_hSxQYoNLzmbZmhJ2uG--vSecrG=ko6ugwg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Jan 15, 2017 at 10:08:43PM -0800, Liam Breck wrote:
> 

> Reading both fault and status registers and logging any fault should
> take priority over handling status register update.
> 
> Fix by moving the status handling to later in interrupt routine.
> 
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---

Assuming you fix the >80 chars issue pointed out before with the code that
is moved by this patch:

Acked-by: Mark Greer <mgreer@animalcreek.com>
