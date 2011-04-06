From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
 devices
Date: Wed, 6 Apr 2011 10:49:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104061043220.1907-100000__28498.5048034743$1302102192$gmane$org@iolanthe.rowland.org>
References: <20110406095240.410b4e7e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110406095240.410b4e7e@endymion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, Sonny Rao <sonnyrao@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Apr 2011, Jean Delvare wrote:

> On Wed, 6 Apr 2011 06:23:35 +0100, Mark Brown wrote:
> > On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
> > > This improves our resume time when we have devices on an i2c bus
> > > that are slow to resume.  In particular we have a light sensor that
> > > adds about 50ms of resume time on one device. We have to enable it
> > > both on the i2c master and i2c client side and then we get fully async
> > > suspend/resume.  I suspect we'll see nice gains on systems with more
> > > i2c devices and will test that out soon.
> > > 
> > > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > 
> > It'd probably help if the patch explained why this is safe - my
> > immediate question is why if it's safe to just unconditionally enable
> > async suspend for all I2C clients and adaptors it's not safe to do so
> > for all devices of all types?
> 
> I have exactly the same concern. From
> Documentation/ABI/testing/sysfs-devices-power:
> 
> 	It generally is unsafe to permit the asynchronous suspend/resume
> 	of a device unless it is certain that all of the PM dependencies
> 	of the device are known to the PM core.  However, for some
> 	devices this attribute is set to "enabled" by bus type code or
> 	device drivers and in that cases it should be safe to leave the
> 	default value.
> 
> As I don't see any code being added to guarantee that "all of the PM
> dependencies of the device are known to the PM core", I am skeptical
> about the general correctness of the proposed change.
> 
> On the other hand, a quick grep on the kernel tree shows that the scsi,
> usb and pci subsystem enable async suspend unconditionally for all
> devices. This seems quite contradictory with the quoted statement
> above. Rafael, can you please clarify? Is the attribute description too
> alarmist, or are the subsystems too optimistic? ;)

Neither is the case.  For these subsystems, the PM dependencies _are_ 
known.

The statement in the Documentation file refers to dependencies other 
than the usual parent-child relationships.  PCI and SCSI have no such 
dependencies.  In USB some do exist, but the subsystem code knows about 
them and takes them into account.  Grep for "device_pm_wait_for_dev" in 
the appropriate subtrees and you'll see what I mean.

Now, I have no idea what the situation is with regard to I2C...

Alan Stern
