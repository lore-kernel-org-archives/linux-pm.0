From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 1/6] mfd: max8997: Use regmap to access registers
Date: Thu, 02 Jun 2016 06:43:19 +0200
Message-ID: <574FB967.7090201@samsung.com>
References: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
 <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
 <574EC8EE.5000509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <574EC8EE.5000509@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, r.baldyga@hackerion.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 06/01/2016 01:37 PM, Jacek Anaszewski wrote:
> Hi Krzysztof,
> 
> One thing drew my attention while reviewing this again:
> max8997_led_brightness_set() can sleep, but the brightness_set
> op it is assigned to must not sleep. At the time when this driver was
> merged we were delegating brightness setting to workqueues task
> in LED class drivers that can sleep during this call.
> This must have been overlooked, which is even more likely, taking into
> account that the initial patch doesn't have LED maintainer's ack.
> 
> The non-sleeping requirement is motivated by the fact that brightness
> can be set from softirq context, e.g. when timer trigger is enabled.
> 
> Currently LED class drivers don't have to use workqueue on their own,
> but are required to use brightness_set_blocking op instead of
> brightness_set if they can sleep while setting brightness.
> 
> Apart of that, I think that operations in max8997_led_brightness_set()
> should be protected with mutex to assure leaving the device in
> a consistent state in case of concurrent calls.
> 
> I am aware that this is out of this patch scope, but I'd be grateful
> if you could apply those changes and test them on hardware if you have
> an access to.

The problem you mention existed before the patch. It was using sleeping
primitives (mutex) before adding regmap so I understand you don't have
anything against this patch, right?

I can fix the issue but it will be a little bit trickier because I don't
have the hardware. Other guys in the team tested the patchset for me so
I rely on them in that matter. Anyway I'll work on it.

Best regards,
Krzysztof
