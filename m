From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/5] thermal: rockchip: improve conversion error
 messages
Date: Tue, 29 Nov 2016 21:04:21 -0800
Message-ID: <20161130050420.GB27079@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-2-git-send-email-wxt@rock-chips.com>
 <20161129015155.GA3329@localhost.localdomain>
 <20161129054728.GA64845@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34451 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbcK3FEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:04:24 -0500
Content-Disposition: inline
In-Reply-To: <20161129054728.GA64845@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hey,

On Mon, Nov 28, 2016 at 09:47:29PM -0800, Brian Norris wrote:
> Hi,
> 

<cut>

> > > +		       __func__, table.mode);
> > 
> > Given that we are improving messages, would it be more informative to
> > say that you have an invalid table mode?
> 
> I considered the mode and ID listing to go hand in hand, so it was the
> whole table that is wrong. But it is just as well to say the "table
> mode" is wrong.
> 
> Maybe even better: "%s: unknown table mode: %d\n".
> 

Yup, that works for me, even better.

> And I guess same answer for patch 4, where you had the same question.

yes

> 
> Brian
> 
> > > +		return -EINVAL;
