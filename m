From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] ACPI / PCI: Fix NULL pointer dereference
	in	acpi_get_pci_dev() (rev. 2)
Date: Wed, 14 Oct 2009 16:41:06 -0600
Message-ID: <20091014224106.GF22797@ldl.fc.hp.com>
References: <200910060130.43246.rjw@sisk.pl> <200910130101.57595.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910130101.57595.rjw@sisk.pl>
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
Cc: chepioq@gmail.com, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Danny Feng <dfeng@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl>:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> acpi_get_pci_dev() may be called for a non-PCI device, in which case
> it should return NULL.  However, it assumes that every handle it
> finds in the ACPI CA name space, between given device handle and the
> PCI root bridge handle, corresponds to a PCI-to-PCI bridge with an
> existing secondary bus.  For this reason, when it finds a struct
> pci_dev object corresponding to one of them, it doesn't check if
> its 'subordinate' field is a valid pointer.  This obviously leads to
> a NULL pointer dereference if acpi_get_pci_dev() is called for a
> non-PCI device with a PCI parent which is not a bridge.
> 
> To fix this issue make acpi_get_pci_dev() check if pdev->subordinate
> is not NULL for every device it finds on the path between the root
> bridge and the device it's supposed to get to and return NULL if the
> "target" device cannot be found.
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
> regression from 2.6.30.
 
Acked-by: Alex Chiang <achiang@hp.com>

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Jesse, Len,
> 
> This is a replacement for the original $subject patch (now in the Len's tree
> as commit 5988eaded02e3cca2702f46efc255143468255bd).
> 
> The code was correct, but the comment and the changelog were not.  Please
> use the one below instead.
> 
> Thanks,
> Rafael
> 
