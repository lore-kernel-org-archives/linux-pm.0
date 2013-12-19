From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] thermal: imx_thermal: add module device table
Date: Thu, 19 Dec 2013 11:10:35 +0000
Message-ID: <20131219111035.GJ4360@n2100.arm.linux.org.uk>
References: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
 <52B1B587.3050106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52B1B587.3050106@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 18, 2013 at 10:47:35AM -0400, Eduardo Valentin wrote:
> On 16-12-2013 17:50, Russell King wrote:
> > Add the module device table declaration so the module can be loaded
> > automatically at boot time.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

As you acked this patch, I'm assuming that means you're happy for me to
push it upstream.
