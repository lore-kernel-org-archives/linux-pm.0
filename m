From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
Date: Fri, 01 Mar 2019 15:45:29 +0200
Message-ID: <87h8cmhfnq.fsf@kamboji.qca.qualcomm.com>
References: <3687330.FyvvPAkb64@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
In-Reply-To: <3687330.FyvvPAkb64@aspire.rjw.lan> (Rafael J. Wysocki's message
 of "Fri, 01 Mar 2019 13:51:54 +0100")
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
Cc: Todd Brandt <todd.e.brandt@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ath10k@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

'F' chraracter is missing.

> ath10k_mac_vif_chan() always returns an error for the given vif
> during system-wide resume which reliably triggers two WARN_ON()s
> in ath10k_bss_info_changed() and they are not particularly
> useful in that code path, so drop them.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And could you CC linux-wireless, please? That way the patchwork will see
it and I can take it directly from there.

-- 
Kalle Valo
