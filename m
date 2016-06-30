From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH 12/21] usb: chipidea: msm: Keep device runtime enabled
Date: Wed, 29 Jun 2016 17:43:30 -0700
Message-ID: <146724741028.16253.4741331543289283958@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-13-stephen.boyd@linaro.org>
 <20160629064600.GG25236@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160629064600.GG25236@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <narmstrong@baylibre.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Peter Chen (2016-06-28 23:46:00)
> On Sun, Jun 26, 2016 at 12:28:29AM -0700, Stephen Boyd wrote:
> > Sometimes the usb wrapper device is part of a power domain that
> > needs to stay on as long as the device is active. Let's get and
> > put the device in driver probe/remove so that we keep the power
> > domain powered as long as the device is attached. We can fine
> > tune this later to handle wakeup interrupts, etc. for finer grain
> > power management later, but this is necessary to make sure we can
> > keep accessing the device right now.
> 
> Since some of the controllers work abnormal if we enables runtime
> pm unconditionally, so I use one system flag CI_HDRC_SUPPORTS_RUNTIME_PM
> for it. I can't understand why you can't access device without enable
> parent's runtime pm, the controller will not enter runtime suspend
> without that flag.

Correct, the child device of ci_hdrc_msm will be able to do runtime PM
and keep the parent enabled if the CI_HDRC_SUPPORTS_RUNTIME_PM flag is
set. But even if that flag isn't set, the ci_hdrc_msm driver is calling
pm_runtime_enable() on the same device that it would be called on if the
CI_HDRC_SUPPORTS_RUNTIME_PM flag was set. That allows runtime PM
transition of child devices such as the usb ports (usb1-port1 for
example) to propagate up all the way to the ci_hdrc_msm device and
disable any attached power domains.

Why don't we call runtime PM functions on the ci->dev for all cases of
ci->supports_runtime_pm? It seems like the glue drivers should be
managing their own device power states and the ci->dev should be managed
by core.c code.

Another solution would be to remove the call to pm_runtime_enable() from
ci_hdrc_msm. That would make sure we don't call the power domain code
when the device changes runtime PM states and rely on the fact that
power domains are turned on during device driver probe.
