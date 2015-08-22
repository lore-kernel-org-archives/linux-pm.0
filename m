From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 21/21] ARM: pxa: magician: Move platform_add_devices()
 to the end of magician_init()
Date: Sat, 22 Aug 2015 18:27:30 +0200
Message-ID: <87r3mv47bh.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25B07.1080703@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55D25B07.1080703@tul.cz> (Petr Cvek's message of "Tue, 18 Aug
 2015 00:07:03 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Cvek <petr.cvek@tul.cz>, philipp.zabel@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, lee.jones@linaro.org, j.anaszewski@samsung.com, daniel@zonque.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Move platform_add_devices() to the end of magician_init() for better
> clarity of code.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
With Philipp's ack.

-- 
Robert
