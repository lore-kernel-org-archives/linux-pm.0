From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] thermal: rockchip: ensure the otp state before
 resetting the controller
Date: Tue, 27 Oct 2015 11:23:22 +0100
Message-ID: <CACRpkdaRhpmgZLUAOrHN99GwYDbXhF0Mmi7WuQPAtC4aEsZDJQ@mail.gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
	<1445332264-6054-3-git-send-email-wxt@rock-chips.com>
	<CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
	<5626ED35.3010403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5626ED35.3010403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 21, 2015 at 3:41 AM, Caesar Wang <caesar.upstream@gmail.com> wrote:
>> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:

>> You'd still want to have a bindings change to describe "init", but at
>> least you shouldn't need any code changes.
>
> Okay, https://patchwork.kernel.org/patch/5055741/ that's working for me.
> Fell free add my  test tag if you resend the patch. (Tested-by: Caesar Wang
> <wxt@rock-chips.com>)

Doug, can you resend this rebased version with Caesar's Test tag?
I kinda like this more than any alternatives.

Yours,
Linus Walleij
