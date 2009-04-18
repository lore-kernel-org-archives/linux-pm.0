From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sun, 19 Apr 2009 00:44:57 +0200
Message-ID: <200904190044.58444.rjw__10390.066370792$1240095133$gmane$org@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<20090418135323.GA7148@flint.arm.linux.org.uk>
	<alpine.LFD.2.00.0904181205010.4042@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904181205010.4042@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 18 April 2009, Linus Torvalds wrote:
> 
> On Sat, 18 Apr 2009, Russell King wrote:
> > 
> > What I need to be able to do is to suspend most devices on the host side
> > which may involve talking to a separate microcontroller via I2C to shut
> > down power to peripherals.
> 
> I suspect that for cases like this, the simplest thing to do is to just 
> add a marker for "don't mess with my power management, I'm doing 
> everything through sysdev" for the specified devices.

In this particular case, if sysdev was used, there would be no problem, but the
platform uses a platform device to suspend-resume the i2c controller.
In principle we could convert it to use a sysdev, but that would be more
difficult than the last patch I sent IMO (at least to me).

Also, apparently it is not the only platform doing it.

> Then those i2c controllers (and perhaps some PCI bridges etc) can just set 
> that bit, and the device would basically turn invisible as far as the PM 
> layer is concerned.
> 
> Not that different from the IRQF_TIMER bit for timer interrupts.

I generally agree and a patch to implemet such a flag has been submitted
recently.

Thanks,
Rafael
