From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH] sky2: Do not use legacy PCI power management
Date: Fri, 31 Dec 2010 10:15:21 -0800
Message-ID: <20101231101521.598d41c6__13979.7251242728$1293819489$gmane$org@s6510>
References: <201012261944.32517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012261944.32517.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Dec 2010 19:44:32 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The sky2 driver uses the legacy PCI power management, so it has to do
> some PCI-specific things in its ->suspend() and ->resume() callbacks,
> which isn't necessary and should better be done by the PCI
> sybsystem-level power management code.  Moreover, it uses
> device_set_wakeup_enable() incorrectly (that function should be
> used when the WoL setting is changed rather than during suspend).
> 
> Convert sky2 to the new PCI power management framework and make it
> let the PCI subsystem take care of all the PCI-specific aspects of
> device handling during system power transitions.
> 
> Tested on a desktop machine with a Marvell 88E8056 PCI-E adapter.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Tested on 88E8055 (laptop), my desktop machines have video issues and
won't suspend/resume.

Acked-by: Stephen Hemminger <shemminger@vyatta.com>
