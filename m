From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Export pci_pme_active to drivers
Date: Thu, 7 Aug 2008 15:34:10 -0700
Message-ID: <200808071534.11482.jbarnes__9538.11272415823$1218148595$gmane$org@virtuousgeek.org>
References: <200808051730.27599.alessandro.guido@gmail.com>
	<200808080000.07156.rjw@sisk.pl> <200808080014.25493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808080014.25493.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 7, 2008 3:14 pm Rafael J. Wysocki wrote:
> PCI PM: Export pci_pme_active to drivers
>
> Export pci_pme_active() to drivers, so that they can clear the
> PME_status bit and disable PME# for their devices without involving
> ACPI.

Cool, applied.  Thanks Rafael.

Jesse
