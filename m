From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
Date: Sun, 03 Mar 2019 18:24:55 +0100
Message-ID: <2109586.0yxO8rlmZ5@aspire.rjw.lan>
References: <3687330.FyvvPAkb64@aspire.rjw.lan>
 <87h8cmhfnq.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
In-Reply-To: <87h8cmhfnq.fsf@kamboji.qca.qualcomm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Todd Brandt <todd.e.brandt@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ath10k@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, March 1, 2019 2:45:29 PM CET Kalle Valo wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> 'F' chraracter is missing.
> 
> > ath10k_mac_vif_chan() always returns an error for the given vif
> > during system-wide resume which reliably triggers two WARN_ON()s
> > in ath10k_bss_info_changed() and they are not particularly
> > useful in that code path, so drop them.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> And could you CC linux-wireless, please? That way the patchwork will see
> it and I can take it directly from there.

Done, thank you!
