From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v2] PCI / PM: Add kerneldoc description of
 pci_pm_reset()
Date: Fri, 8 Apr 2011 12:50:31 -0700
Message-ID: <20110408125031.09d667f2__38908.5409966812$1302292320$gmane$org@jbarnes-desktop>
References: <201103051324.27461.rjw@sisk.pl> <201103052148.44413.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103052148.44413.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Mar 2011 21:48:44 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The pci_pm_reset() function is not a very nice interface due to its
> limitations and conditional behavior (e.g. it doesn't affect devices
> in low-power states), but it cannot be simply dropped, because
> existing device drivers may depend on it.  However, its behavior and
> limitations should be well documented, so add an appropriate
> kerneldoc comment to it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Applied to linux-next, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
