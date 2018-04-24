From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: dt: Allow platforms to provide
 suspend/resume hooks
Date: Tue, 24 Apr 2018 14:47:05 +0530
Message-ID: <20180424091705.ar6vzzuljjz44qp5@vireshk-i7>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
 <20180424110825.50436168@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180424110825.50436168@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 24-04-18, 11:08, Miquel Raynal wrote:
> I tested on an EspressoBin (Armada 3720), it works.

Great.

> However, I first had a panic due to the clock being 'put' twice. I
> suggest you to merge this [1] into the second patch. With this (or
> something similar):

NULL is a valid clock. I have fixed it now, a bit differently though.

> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks.

> And the path error was reached because I did not select the cpufreq-dt
> driver in menuconfig, which I think should be selected by default when
> enabling the armada37xx-cpufreq driver. I wrote a small patch for
> that too, see [2]. Tell me if you want me to send it of if you want to
> include it in the next version ?

Maybe just send that separately (and you don't need to resend any of
the patches which are part of this series).

-- 
viresh
