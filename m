From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] e1000e / PCI / PM: Add basic runtime PM
 support (rev. 4)
Date: Tue, 16 Mar 2010 21:29:57 -0700 (PDT)
Message-ID: <20100316.212957.45789917.davem__43456.9871439182$1268800367$gmane$org@davemloft.net>
References: <201003150131.59619.rjw@sisk.pl> <201003150135.17564.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003150135.17564.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org, romieu@fr.zoreil.com, jesse.brandeburg@intel.com, jbarnes@virtuousgeek.org, jeffrey.t.kirsher@intel.com, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 15 Mar 2010 01:35:17 +0100

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Use the PCI runtime power management framework to add basic PCI
> runtime PM support to the e1000e driver.  Namely, make the driver
> suspend the device when the link is off and set it up for generating
> a wakeup event after the link has been detected again.  [This
> feature is disabled until the user space enables it with the help of
> the /sys/devices/.../power/contol device attribute.]
> 
> Based on a patch from Matthew Garrett.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied.
