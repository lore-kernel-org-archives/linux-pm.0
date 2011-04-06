From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 09:52:40 +0200
Message-ID: <20110406095240.410b4e7e@endymion.delvare>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
	<20110406052335.GA25578@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110406052335.GA25578@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks
	(embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Apr 2011 06:23:35 +0100, Mark Brown wrote:
> On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
> > This improves our resume time when we have devices on an i2c bus
> > that are slow to resume.  In particular we have a light sensor that
> > adds about 50ms of resume time on one device. We have to enable it
> > both on the i2c master and i2c client side and then we get fully async
> > suspend/resume.  I suspect we'll see nice gains on systems with more
> > i2c devices and will test that out soon.
> > 
> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> 
> It'd probably help if the patch explained why this is safe - my
> immediate question is why if it's safe to just unconditionally enable
> async suspend for all I2C clients and adaptors it's not safe to do so
> for all devices of all types?

I have exactly the same concern. From
Documentation/ABI/testing/sysfs-devices-power:

	It generally is unsafe to permit the asynchronous suspend/resume
	of a device unless it is certain that all of the PM dependencies
	of the device are known to the PM core.  However, for some
	devices this attribute is set to "enabled" by bus type code or
	device drivers and in that cases it should be safe to leave the
	default value.

As I don't see any code being added to guarantee that "all of the PM
dependencies of the device are known to the PM core", I am skeptical
about the general correctness of the proposed change.

On the other hand, a quick grep on the kernel tree shows that the scsi,
usb and pci subsystem enable async suspend unconditionally for all
devices. This seems quite contradictory with the quoted statement
above. Rafael, can you please clarify? Is the attribute description too
alarmist, or are the subsystems too optimistic? ;)

Original post for reference:
http://marc.info/?l=linux-i2c&m=130206741920878&w=2

Sonny, on how many systems did you test it? In particular, did you test
it on several TV cards (which use I2C a lot and sometimes in complex
setups)?

-- 
Jean Delvare
