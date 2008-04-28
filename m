From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Mon, 28 Apr 2008 15:26:47 -0700
Message-ID: <200804281526.48217.david-b__33134.0344892398$1209421826$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200804261237.26499.david-b@pacbell.net>
	<1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
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
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[ grr, mousepad sent an incomplete message for me ... ]

On Monday 28 April 2008, Zhao Yakui wrote:
> =

> > > But after the patch is applied, some PCI device(the ACPI device with =
the
> > > _PRW object) can wake the sleeping system by default. And it is total=
ly
> > > opposite to the current flowchart. =

> > =

> > That's not true. =A0Behavior could only change for devices with
> > drivers which already call pci_enable_wake()!
> =

> Yes. But in fact a lot of PCI device will call pci_enable_wake when the
> system enters the suspend state. And the behaviour will be changed.

I'm not sure what your point is.  That "behavior change" is a bugfix.
The previous behavior was specific to ACPI, and obviously was not what
the driver writer expected.

And it's *NOT* how things work on non-ACPI systems which have both PCI
and functional system suspend/resume.  (Various PowerPC, MIPS, and ARM
systems meet those requirements, as I understand.)

I sympathize with the desire to avoid driver-related surprises.  In
this case, it's trivial to disable that behavior using sysfs.  And I
believe you'll observe that not many drivers could actually turn up
surprises here:  who calls pci_enable_wake()?

- Dave
