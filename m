From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce
 acpi_pm_device_sleep_wake function
Date: Thu, 26 Jun 2008 16:38:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806261636430.5244-100000__16188.0906591707$1214513033$gmane$org@iolanthe.rowland.org>
References: <200806262231.35375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806262231.35375.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Jun 2008, Rafael J. Wysocki wrote:

> > > Do you think the core should clear PME# status automatically in that case?
> > 
> > Yes.
> 
> Okay, but that will require us to add the clearing of PME# to the PCI
> resume/restore callbacks.  Perfectly doable, but I'd prefer to do that on top
> of the $subject patch.

That's fine.  I wasn't trying to criticize your new patches, just point
out that overall they are moving in the same direction as this other
work that was done last year.

Alan Stern
