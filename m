From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 5/7] PM: Asynchronous suspend and resume
 of PCI devices
Date: Tue, 18 Aug 2009 09:47:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908180947080.2995-100000__9213.99350413612$1250603434$gmane$org@iolanthe.rowland.org>
References: <1250578628.5351.64.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1250578628.5351.64.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Aug 2009, Zhang Rui wrote:

> On Mon, 2009-08-17 at 08:20 +0800, Rafael J. Wysocki wrote:
> > Set async_suspend for all PCI devices and PCIe port services.
> > =

> =EF=BB=BFAlan said that we can not break the resume order of the uhci/ehc=
i host
> controllers on some platforms.
> =

> For example,
> 00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #4 (rev 02)
> 00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #5 (rev 02)
> 00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
> Controller #2 (rev 02)
> 00:1a.7 must be resumed after 00:1a.0 and 00:1a.1
> =

> please refer to this thread:
> http://marc.info/?l=3Dlinux-acpi&m=3D122996117918188&w=3D2
> =

> So I'm afraid we can not suspend/resume the PCI devices in parallel,
> unless we add this off-tree dependency at the same time.

It's okay for testing.  The dependency is needed mostly for =

resume-from-hibernation.

Alan Stern
