From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 11/12] PCI PM: Run-time callbacks for
	PCI bus type	(rev. 2)
Date: Tue, 1 Dec 2009 22:00:43 +0000
Message-ID: <20091201220043.GA17093__33539.1753040769$1259704938$gmane$org@srcf.ucam.org>
References: <200911160047.46299.rjw@sisk.pl> <200911291632.44763.rjw@sisk.pl>
	<200911291643.15603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911291643.15603.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 29, 2009 at 04:43:15PM +0100, Rafael J. Wysocki wrote:

> -	if (enable && !device_may_wakeup(&dev->dev))
> +	if (enable && runtime && !device_may_wakeup(&dev->dev))

Should this be !runtime? We only care about device_may_wakeup() in the 
system suspend case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
