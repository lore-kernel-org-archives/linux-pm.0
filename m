From: David Brownell <david-b@pacbell.net>
Subject: Re: Fwd: USB suspending
Date: Fri, 05 Oct 2007 12:04:02 -0700
Message-ID: <20071005190401.47833238EE9__40160.0486635745$1191611430$gmane$org@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200710051551.24781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710051551.24781.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org
Cc: xhejtman@ics.muni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

> Subject: USB suspending
> Date: Friday, 5 October 2007 14:54
> From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
> To: "Rafael J. Wysocki" <rjw@sisk.pl>
>
> Hello,
>
> I've noticed that while suspended in RAM USB ports are powered so any device
> connected to the port gets power. Can I turn off power of all USBs ports while
> suspending to RAM?

Usually, no.  On PCs, most root hubs don't support the relevant
root hub "port power off" request.  Also, their ACPI configurations
are set up to expect port power to stay on.

Of course, powering off the USB ports gives only minimal power
savings.  Suspended devices aren't permitted to draw much power,
typically only 0.5 mA.

- Dave
