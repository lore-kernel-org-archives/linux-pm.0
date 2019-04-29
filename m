From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
Date: Mon, 29 Apr 2019 14:26:55 +0000 (UTC)
Message-ID: <20190429142656.5E938607DF@smtp.codeaurora.org>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
In-Reply-To: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Todd Brandt <todd.e.brandt@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> ath10k_mac_vif_chan() always returns an error for the given vif
> during system-wide resume which reliably triggers two WARN_ON()s
> in ath10k_bss_info_changed() and they are not particularly
> useful in that code path, so drop them.
> 
> Tested: QCA6174 hw3.2 PCI with WLAN.RM.2.0-00180-QCARMSWPZ-1
> Tested: QCA6174 hw3.2 SDIO with WLAN.RMH.4.4.1-00007-QCARMSWP-1
> 
> Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> Cc: stable@vger.kernel.org
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Claire Chang <tientzu@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-current branch of ath.git, thanks.

9e80ad37f678 ath10k: Drop WARN_ON()s that always trigger during system resume

-- 
https://patchwork.kernel.org/patch/10837139/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
