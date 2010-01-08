From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/12] PCI PM: Make it possible to force using
 INTx for PCIe PME signaling
Date: Fri, 8 Jan 2010 12:25:03 -0800
Message-ID: <20100108202503.GA31623__38635.14659829$1262984705$gmane$org@kroah.com>
References: <200912272057.10443.rjw@sisk.pl>
	<20100106135625.14b37f10@jbarnes-piketon>
	<20100106220214.GA25366@srcf.ucam.org>
	<201001070000.41807.rjw@sisk.pl>
	<alpine.LFD.2.00.1001081502010.4012@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001081502010.4012@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 08, 2010 at 03:08:03PM -0500, Len Brown wrote:
> Yesterday MSI announced a netbook running Suse/Moblin,
> so there is hope for more technical work w/ MSI to support Linux...

Yes, we are currently working on a patch for the existing msi driver to
get some of the keys to work a bit better.  It's still going through
review back-and-forth between me and the developer, and will be posted
soon.

thanks,

greg k-h
