From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] ath9k: Do not use legacy PCI power management
Date: Mon, 20 Dec 2010 01:05:55 +0100
Message-ID: <4D0E9DE3.8050100__42793.2185856209$1292946858$gmane$org@hauke-m.de>
References: <201010160036.17653.rjw@sisk.pl> <201012200032.21704.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012200032.21704.rjw@sisk.pl>
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
Cc: ath9k-devel@venema.h4ckr.net, "Luis R. Rodriguez" <lrodriguez@atheros.com>, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 12/20/2010 12:32 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The ath9k driver uses legacy PCI power management (system suspend
> and resume) callbacks, so make it use struct dev_pm_ops callbacks and
> let the PCI subsystem handle all of the PCI-specific details of
> system power transitions.
> 
> This change has been tested on Acer Ferrari One with the
> Atheros AR928X PCI Express network adapter (rev. 01).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Hi,
> 
> This patch has been sent already once under a slightly different subject
> and with a different changelog.  I'm not sure what happened to it that time,
> so here it goes again.
> 
> I'm quite confident it doesn't break things and it simplifies the driver's
> suspend and resume routines quite a bit, so please apply.
> 
> Thanks,
> Rafael
> 
Hi Rafael,

Your patch was already applied (see commit
f0e94b479c987abef17eb18e5c8e0ed178d00cd4 in linux-next) or didn't I got
your problem?

Hauke
