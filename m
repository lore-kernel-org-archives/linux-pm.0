From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] PM: make runtime_status attribute not
 debug-only
Date: Fri, 2 Jul 2010 20:29:45 +0200
Message-ID: <20100702182945.GA7374@comet.dominikbrodowski.net>
References: <Pine.LNX.4.44L0.1007021248460.1309-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1007021248460.1309-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


"unsupported" sounds even better ;)

On Fri, Jul 02, 2010 at 12:51:41PM -0400, Alan Stern wrote:
> This patch (as1404) makes the runtime_status sysfs attribute available
> even in the absence of CONFIG_PM_ADVANCED_DEBUG, and it changes the
> routine to display "unknown" when runtime PM is disabled for a device.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
