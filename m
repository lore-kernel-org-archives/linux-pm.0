From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 14:46:20 +0200
Message-ID: <20150710124620.GD3127@piout.net>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net> <559F7AC4.6050008@atmel.com>
 <20150710120907.GC3127@piout.net> <20150710123148.GA28632@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150710123148.GA28632@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Fabian Frederick <fabf@skynet.be>, Josh Wu <josh.wu@atmel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

On 10/07/2015 at 14:31:48 +0200, Maxime Ripard wrote :
> On Fri, Jul 10, 2015 at 02:09:07PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 10/07/2015 at 15:56:52 +0800, Josh Wu wrote :
> > > I would agree with Maxime. Currently all latest chip reset function is
> > > compatible with the atmel,sama5d3-rstc.
> > > So check compatible string is enough for now.
> > > But of cause if we have other incompatible reset in future with new chip,
> > > the structure like you said is needed.
> > 
> > We managed to avoid using of_machine_is_compatible() in all the at91
> > drivers. I'd like to keep it that way. It was painful enough to remove
> > all those cpu_is_at91xxx calls.
> 
> That's your call...
> 
> > Also, using it is trying to match strings and will result in longer boot
> > times.
> 
> Have you looked at the implementation of of_match_device? If that's
> really a concern to you, you should actually avoid it.
> 

Indeed, I misread. of_device_is_compatible is acceptable,
of_machine_is_compatible is not :)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
