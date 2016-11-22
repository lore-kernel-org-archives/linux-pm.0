From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Mon, 21 Nov 2016 19:43:33 -0800
Message-ID: <20161122034332.GA113841@google.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <1479513177-81504-2-git-send-email-briannorris@chromium.org>
 <b6da9490-9a27-4330-7988-cb25724ba345@rock-chips.com>
 <378ade3d-a980-58e4-5253-c16702c74bf3@gmail.com>
 <20161122021506.GA103691@google.com>
 <81605141-dd5b-1714-6486-3381e616a992@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81605141-dd5b-1714-6486-3381e616a992@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 10:33:27AM +0800, Caesar Wang wrote:
> 在 2016年11月22日 10:15, Brian Norris 写道:
> >On Tue, Nov 22, 2016 at 09:51:23AM +0800, Caesar Wang wrote:
> >>CHECK: Alignment should match open parenthesis
> >>#428: FILE: drivers/thermal/rockchip_thermal.c:428:
> >>+    pr_err("%s: invalid temperature, temp=%d error=%d\n",
> >>+        __func__, temp, error);
> >>
> >>CHECK: Alignment should match open parenthesis
> >>#480: FILE: drivers/thermal/rockchip_thermal.c:480:
> >>+        pr_err("%s: invalid conversion table, mode=%d\n",
> >>+            __func__, table->mode);
> >What patch are you checking? I ran mine through checkpatch, and there
> >are no problems.
> 
> That  just checkcode on Chromeos kernelv4.4,  that trivial things :)
> $chromiumos/src/third_party/kernel/v4.4$ checkcode

I'm not familiar with that tool, and that repository isn't upstream
but...

> drivers/thermal/rockchip_thermal.c
> CHECK: Alignment should match open parenthesis
> #428: FILE: drivers/thermal/rockchip_thermal.c:428:
> +    pr_err("%s: invalid temperature, temp=%d error=%d\n",
> +        __func__, temp, error);

...on approximately my 10th read of this...I guess maybe this tool has
determined that 2 tabs is 1 character too much, because the second line
lines up with the '%' instead of the '"'. If this is so important to
you, you can of course edit my patch and include it with yours.

Regards,
Brian
