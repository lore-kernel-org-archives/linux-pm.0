From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH update] ACPI / PM: Allow PCI root
	bridges to wake up the system
Date: Tue, 1 Sep 2009 21:03:19 +0200
Message-ID: <200909012103.19761.rjw__1841.26095050505$1251832391$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200908312324.20850.rjw@sisk.pl>
	<20090901132547.GA13084@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090901132547.GA13084@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 September 2009, Matthew Garrett wrote:
> On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:
> 
> > Updated patch is appended, but there's a problem with it.  Namely, when the
> > root bridge GPE is shared with other devices, those devices are also enabled
> > to wake up and they may be kind of "interesting" (on one of my test boxes they
> > include the ethernet and audio adapters).  I'm not sure what to do about that.
> 
> Perhaps only enable it if a child device is enabled?

Well, the problem is that we have to enable the devices that share the GPE to
wake up together, but the child device we _really_ want to wake-up need not
be any of them.

Also, the child device may be enabled to wake up after we've run the "glue"
code.

Well, perhaps it's better to rework pci_enable_wake() so that it, if the device
doesn't have an ACPI handle and is not PCIe, it will go and enable the root
bridge to wake up as well?

I wonder what about the bridges between the desired wake-up device and the
root bridge.  I guess they also should be enabled to wake-up, so that they can
forward the PME# in case the system is designed this way.

Thoughts?

> This is difficult with the current code - the refcounted GPE stuff I'm
> working on ought to make it easier.

Ah, I think that's going to be useful.

Thanks,
Rafael
