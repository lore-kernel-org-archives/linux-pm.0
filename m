From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] PCI PM: Split PCI Express port
	suspend-resume
Date: Wed, 31 Dec 2008 12:08:40 -0800
Message-ID: <200812311208.41424.jbarnes@virtuousgeek.org>
References: <200812271627.32781.rjw@sisk.pl> <200812271628.58748.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812271628.58748.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 27, 2008 7:28 am Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Suspend-resume of PCI Express ports has recently been moved into
> _suspend_late() and _resume_early() callbacks, but some functions
> executed from there should not be called with interrupts disabled,
> eg. pci_enable_device().  For this reason, split the suspend-resume
> of PCI Express ports into parts to be executed with interrupts
> disabled and with interrupts enabled.

Applied both of these, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
