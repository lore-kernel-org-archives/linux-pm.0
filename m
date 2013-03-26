From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 04/15] cpuidle: OMAP4: remove timer broadcast
 initialization
Date: Tue, 26 Mar 2013 10:11:07 +0530
Message-ID: <515126E3.5050006@ti.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364234140-514-5-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, linaro-kernel@lists.linaro.org, linux@arm.linux.org.uk, jason@lakedaemon.net, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, magnus.damm@gmail.com, rob.herring@calxeda.com, linux@maxim.org.za, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, ben-linux@fluff.org, kgene.kim@samsung.com, tglx@linutronix.de, plagnioj@jcrosoft.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 March 2013 11:25 PM, Daniel Lezcano wrote:
> The initialization is done from the cpuidle framework.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
