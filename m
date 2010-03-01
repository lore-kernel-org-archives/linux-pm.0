From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper	functions
Date: Mon, 1 Mar 2010 13:31:29 +0000
Message-ID: <20100301133129.GB10658@sirena.org.uk>
References: <201002262224.02694.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1002261702070.2029-100000@iolanthe.rowland.org>
	<20100227104309.GB2994@sirena.org.uk>
	<201002272350.16523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002272350.16523.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 27, 2010 at 11:50:16PM +0100, Rafael J. Wysocki wrote:

> What about the patch below, then (untested)?

> Use GENERIC_SUBSYS_PM_OPS for the subsystem and then
> UNIVERSAL_DEV_PM_OPS for drivers, possibly passing NULL as idle_fn.

I've not tested but yes, this looks really helpful for my use cases.
