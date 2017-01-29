From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: syscon-poweroff: add a mask property
Date: Sun, 29 Jan 2017 14:04:00 +0200
Message-ID: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


The syscon-poweroff driver powers off the machine by writing a value to
a register. Both the register and the value are configured via the
device tree.

I encountered a situation where I need to mask the written value - some
values of the register must remain unchanged during the power-down.
(This is required to turn on the i.mx6ul using the RTC. See [1] for more
details.)

Unfortunately, the property of the register value is currently named
mask, so we can't just add a "mask" property.

The solutions I could think of:
1) Add a new mask property and name it "mask_mask" or something like
that.
2) Create a new "syscon-masked-poweroff" driver that will have value and
mask properties.

What do you think?


[1] https://www.spinics.net/lists/arm-kernel/msg555580.html
