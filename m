From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] cpufreq: ap806: fix possible object reference leak
Date: Mon, 8 Apr 2019 15:51:32 +0530
Message-ID: <20190408102132.jeuulxxwkyvbppdp@vireshk-i7>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
 <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01-04-19, 09:37, Wen Yang wrote:
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/cpufreq/armada-8k-cpufreq.c:187:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.
> ./drivers/cpufreq/armada-8k-cpufreq.c:191:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)

I haven't received the cover-letter and patch 4/7 (because the tags in that
commit were incorrect). I have applied all the 7 patches to my cpufreq tree
though.

Thanks.

-- 
viresh
