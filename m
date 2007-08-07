From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume routines
Date: Tue, 7 Aug 2007 16:03:57 -0700
Message-ID: <20070807160357.d6ea9731.akpm__43500.2950639047$1186527888$gmane$org@linux-foundation.org>
References: <200708052114.01790.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708052114.01790.rjw@sisk.pl>
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
Cc: Grant Grundler <grundler@parisc-linux.org>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, Kyle McMartin <kyle@mcmartin.ca>, list <linux-pm@lists.linux-foundation.org>, pm@smtp2.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 5 Aug 2007 21:14:01 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +#ifdef CONFIG_PM_SLEEP
> +
> +/*
> + *	Suspend the interface.
> + */
> +
> +static int uli526x_suspend(struct pci_dev *pdev, pm_message_t state)

Since when did suspend and resume methods become dependent upon CONFIG_PM_SLEEP?

We have eight thousand implementations of this, all of which presently
use CONFIG_PM.
