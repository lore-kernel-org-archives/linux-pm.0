From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 12:06:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904181205010.4042__22824.035320855$1240082283$gmane$org@localhost.localdomain>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181523.36010.rjw@sisk.pl>
	<20090418135323.GA7148@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090418135323.GA7148@flint.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 18 Apr 2009, Russell King wrote:
> 
> What I need to be able to do is to suspend most devices on the host side
> which may involve talking to a separate microcontroller via I2C to shut
> down power to peripherals.

I suspect that for cases like this, the simplest thing to do is to just 
add a marker for "don't mess with my power management, I'm doing 
everything through sysdev" for the specified devices.

Then those i2c controllers (and perhaps some PCI bridges etc) can just set 
that bit, and the device would basically turn invisible as far as the PM 
layer is concerned.

Not that different from the IRQF_TIMER bit for timer interrupts.

			Linus
