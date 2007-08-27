From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] wake up from a serial port
Date: Mon, 27 Aug 2007 19:30:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708271924180.5705@poirot.grange>
References: <Pine.LNX.4.60.0708260010250.3809@poirot.grange>
	<20070827100029.GB1972@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070827100029.GB1972@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Aug 2007, Pavel Machek wrote:

> Hi!
> 
> > Enable wakeup from serial ports, make it run-time configurable over sysfs, 
> > e.g.,
> > 
> > echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
> > 
> > Requires
> > 
> > # CONFIG_SYSFS_DEPRECATED is not set
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Hmm, interesting, looks ok to me. What are you using it for?

Linkstation / kurobox systems from Buffalo Tech. have an AVR controller 
connected to host's UART. The AVR controls power, buttons, fan, LEDs, 
sensors... So, practically the only way to wake the system up is to press 
a button, which sends a byte from the AVR to the CPU.

Thanks
Guennadi
---
Guennadi Liakhovetski
