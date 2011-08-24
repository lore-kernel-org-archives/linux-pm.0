From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2/2 v2] sh-sci / PM: Use power.irq_safe
Date: Wed, 24 Aug 2011 14:33:18 +0900
Message-ID: <20110824053317.GC26391__3440.30115888945$1314164171$gmane$org@linux-sh.org>
References: <201108202131.19479.rjw@sisk.pl> <201108212109.30399.rjw@sisk.pl>
	<201108212111.45012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108212111.45012.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 21, 2011 at 09:11:44PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since sci_port_enable() and sci_port_disable() may be run with
> interrupts off and they execute pm_runtime_get_sync() and
> pm_runtime_put_sync(), respectively, the SCI device's
> power.irq_safe flags has to be used to indicate that it is safe
> to execute runtime PM callbacks for this device with interrupts off.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Not sure how you want this one handled. Did you simply want to roll this
in with your other patch with my Acked-by, or should I be taking this
through my tree already regardless of the 1/2 patch?
