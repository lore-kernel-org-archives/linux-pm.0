From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH, RFC] wake up from a serial port
Date: Mon, 27 Aug 2007 12:00:29 +0200
Message-ID: <20070827100029.GB1972__45445.1915495612$1188216584$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.60.0708260010250.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0708260010250.3809@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Enable wakeup from serial ports, make it run-time configurable over sysfs, 
> e.g.,
> 
> echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
> 
> Requires
> 
> # CONFIG_SYSFS_DEPRECATED is not set
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hmm, interesting, looks ok to me. What are you using it for?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
