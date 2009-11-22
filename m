From: Bob Copeland <me@bobcopeland.com>
Subject: Re: [Resend][PATCH] Wireless / ath5k: Simplify suspend
	and resume	callbacks
Date: Sat, 21 Nov 2009 22:18:46 -0500
Message-ID: <20091122031846.GA6215__19490.72776265$1258860082$gmane$org@hash.localnet>
References: <200911212344.24170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911212344.24170.rjw@sisk.pl>
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
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, ath5k-devel@venema.h4ckr.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 21, 2009 at 11:44:24PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Wireless / ath5k: Simplify suspend and resume callbacks
> 
> Simplify the suspend and resume callbacks of ath5k by converting the
> driver to struct dev_pm_ops and allowing the PCI PM core to do the
> PCI-specific suspend/resume handling.
> 
> Tested with Atheros Communications Inc. AR2413 802.11bg NIC (rev 01)
> D-Link CardBus.adapter.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Bob Copeland <me@bobcopeland.com>

Thanks for the resend, sorry it got lost in the shuffle.

-- 
Bob Copeland %% www.bobcopeland.com
