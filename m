From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Tue, 13 Dec 2016 11:07:13 +0100
Message-ID: <20161213100713.GC24175@bigcity.dyn.berto.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
 <20161212214514.GA17631@katana>
 <CAMuHMdXPZvHPRNx_VJ5VkowcTZbt_tOtRE1yPPVfv2fMYL8xLA@mail.gmail.com>
 <20161213083903.GA2773@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37046 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcLMKHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2016 05:07:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id t79so111742428wmt.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2016 02:07:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161213083903.GA2773@katana>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>

On 2016-12-13 09:39:04 +0100, Wolfram Sang wrote:
> 
> > Perhaps the macros should be called e.g. FIXPT_MUL() and FIXPT_DIV()?
> 
> Yes, that naming would be more readable to me.
> 

FIXPT_ is a much better prefix, will update in next version. Thanks for 
the suggestion Geert.

-- 
Regards,
Niklas Söderlund
