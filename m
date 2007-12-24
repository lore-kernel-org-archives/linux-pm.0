From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to fix nForce
	4 suspend-to-RAM
Date: Mon, 24 Dec 2007 21:53:47 +0000
Message-ID: <200712242153.48906.carlos__19399.5321206332$1198781849$gmane$org@strangeworlds.co.uk>
References: <200712231419.40207.carlos@strangeworlds.co.uk>
	<200712241444.24031.rjw@sisk.pl>
	<alpine.LFD.0.9999.0712241008150.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.9999.0712241008150.21557@woody.linux-foundation.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday 24 December 2007 18:34:21 Linus Torvalds wrote:
> On Mon, 24 Dec 2007, Rafael J. Wysocki wrote:
> > Well, having considered that for a longer while, I think the AML code is
> > referring to a device that we have suspended already, and since it's in a
> > low power state, it just can't handle the reference.
> >
> > If that is the case, we'll have to find the device (that should be
> > possible using some code instrumentation) and move the suspending of it
> > into the late stage.
>
> Yes.

My own experimentation (in device_suspend(), calling _PTS() in the AML after 
each suspend_device() runs, until one device causes it to hang) points to 
ohci_hcd being the culprit here (with or without any devices attached). With 
the ohci_hcd module unloaded, the machine suspends just fine[1].

Of course, I'm at a complete loss as to why suspending OHCI would cause a 
problem for an IO port write.

> NOTE! This following patch is just for discussion, and while I think it's
> conceptually a good thing to try, I don't think it will help Carlos'
> problem. But removing the "pci_set_power_state()" in agp_nvidia_suspend()
> might.

nvidia-agp cannot be built on x86-64, so it's not the culprit in this case.

-Carlos

[1] And yes, I double checked the custom DSDT is not loaded this time.
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
