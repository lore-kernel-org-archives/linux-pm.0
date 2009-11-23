From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH] Wireless / ath5k: Simplify suspend
	and resume callbacks
Date: Mon, 23 Nov 2009 23:12:18 +0100
Message-ID: <200911232312.18344.rjw__27469.7518827908$1259014407$gmane$org@sisk.pl>
References: <200911212344.24170.rjw@sisk.pl>
	<20091123213353.GA9045@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091123213353.GA9045@tuxdriver.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@gmail.com>, netdev@vger.kernel.org, Bob Copeland <me@bobcopeland.com>, LKML <linux-kernel@vger.kernel.org>, ath5k-devel@venema.h4ckr.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 November 2009, John W. Linville wrote:
> On Sat, Nov 21, 2009 at 11:44:24PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: Wireless / ath5k: Simplify suspend and resume callbacks
> > 
> > Simplify the suspend and resume callbacks of ath5k by converting the
> > driver to struct dev_pm_ops and allowing the PCI PM core to do the
> > PCI-specific suspend/resume handling.
> > 
> > Tested with Atheros Communications Inc. AR2413 802.11bg NIC (rev 01)
> > D-Link CardBus.adapter.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> This is already queued for -next.

Thanks!

Rafael
