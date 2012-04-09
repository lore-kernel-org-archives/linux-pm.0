From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 5/5] cpuidle: coupled: add trace events
Date: Mon, 09 Apr 2012 12:29:20 +0530
Message-ID: <4F8288C8.50507@ti.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
	<1331749794-8056-6-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1331749794-8056-6-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 March 2012 11:59 PM, Colin Cross wrote:
> Adds trace events to allow debugging of coupled cpuidle.
> Can be used to verify cpuidle performance, including time spent
> spinning and time spent in safe states.  Not intended for merging.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
I found the trace events quite useful for debug and also to monitor
the cpuidle performance.

I guess we should add these trace events to the core code unless
and until there is a strong reason not to do so.

Regards
Santosh
