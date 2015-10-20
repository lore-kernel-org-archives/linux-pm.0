From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
Date: Tue, 20 Oct 2015 09:01:38 -0700
Message-ID: <CAD=FV=Vo1Wf6opTc5jQjm-nXd=BCJxeggipPj4ER9Ehutxs_6w@mail.gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
	<1445332264-6054-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36633 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbJTQBk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 12:01:40 -0400
Received: by ykba4 with SMTP id a4so15094944ykb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 09:01:39 -0700 (PDT)
In-Reply-To: <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Caesar,

On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> As the TRM says, the TSHUT default state is high active.
> In general, the TSHUT state can get from the dts. Otherwise
> it gets the state from this.

Can you point at where the TRM says that the default state is high active?

With the manual I have, I look at TSADC_AUTO_CON and I look at the
description of "Bit 8".  It says that "tshut polarity" is 0 for low
active and 1 for high active.  It then said that the Reset Value is 0.

...the "Reset Value" in tables like this is notoriously unreliable, so
I can totally believe that it's wrong.  If you can point me at the
part of the TRM that says that TSHUT is high active by default then I
can confirm that for you.  ;)


-Doug
