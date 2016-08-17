From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Fix error return code
Date: Wed, 17 Aug 2016 16:16:09 +0200
Message-ID: <57B471A9.8060103@linaro.org>
References: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/11/2016 03:02 PM, Christophe JAILLET wrote:
> We know that 'ret = 0' because it has been tested a few lines above.
> So, if 'kzalloc' fails, 0 will be returned instead of an error code.
> Return -ENOMEM instead.
> 
> Fixes: a0d46a3dfdc3 ("ARM: cpuidle: Register per cpuidle device")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks !

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
