From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM: Make system-wide PM and runtime
 PM handle subsystems consistently
Date: Wed, 16 Feb 2011 09:57:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102160955210.2108-100000__15832.52475034$1297922930$gmane$org@iolanthe.rowland.org>
References: <201102161324.49633.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102161324.49633.rjw@sisk.pl>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Feb 2011, Rafael J. Wysocki wrote:

> Unfortunately, it doesn't work on my Acer Ferrari One.  The problem is that
> hcd_pci_suspend() fails for the EHCI controller, apparently because the root
> hub is not suspended.  Do root hubs need both class suspend and bus type
> suspend to work at the same time?

No, only the bus type suspend method is needed.  Can you provide the
dmesg log using a kernel built with CONFIG_USB_DEBUG?

Alan Stern
