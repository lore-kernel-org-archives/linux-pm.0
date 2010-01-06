From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/12] PCI PM: PCIe PME root port service
	driver (rev. 5)
Date: Wed, 6 Jan 2010 13:53:30 -0800
Message-ID: <20100106135330.44baa6d3__45934.5046933324$1262814871$gmane$org@jbarnes-piketon>
References: <200912272057.10443.rjw@sisk.pl> <200912272101.25036.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912272101.25036.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver@smtp1.linux-foundation.org, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Shaohua@smtp1.linux-foundation.org, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 Dec 2009 21:01:24 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCIe native PME detection mechanism is based on interrupts generated
> by root ports or event collectors every time a PCIe device sends a
> PME message upstream.
> 
> Once a PME message has been sent by an endpoint device and received
> by its root port (or event collector in the case of root complex
> integrated endpoints), the Requester ID from the message header is
> registered in the root port's Root Status register.  At the same
> time, the PME Status bit of the Root Status register is set to
> indicate that there's a PME to handle.  If PCIe PME interrupt is
> enabled for the root port, it generates an interrupt once the PME
> Status has been set.  After receiving the interrupt, the kernel can
> identify the PCIe device that generated the PME using the Requester
> ID from the root port's Root Status register. [For details, see PCI
> Express Base Specification, Rev. 2.0.]
> 
> Implement a driver for the PCIe PME root port service working in
> accordance with the above description.
> 
> Based on a patch from Shaohua Li <shaohua.li@intel.com>.

This one looks pretty nice.

-- 
Jesse Barnes, Intel Open Source Technology Center
