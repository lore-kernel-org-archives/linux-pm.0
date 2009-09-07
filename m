From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 3/3] PCI PM: Run-time callbacks for PCI
 bus type
Date: Sun, 6 Sep 2009 21:56:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0909062155340.30707-100000__44194.9268839837$1252288683$gmane$org@netrider.rowland.org>
References: <200909070105.25835.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909070105.25835.rjw@sisk.pl>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Sep 2009, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce run-time PM callbacks for the PCI bus type.  Make the new
> callbacks work in analogy with the existing system sleep PM
> callbacks, so that the drivers already converted to struct dev_pm_ops
> can use their suspend and resume routines for run-time PM without
> modifications.

Do you want to arrange things so that PCI devices with no driver will 
get runtime-suspended by default?

Alan Stern
