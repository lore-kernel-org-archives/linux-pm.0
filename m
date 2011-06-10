From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 10:51:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106101050140.1921-100000__19219.5482356057$1307717530$gmane$org@iolanthe.rowland.org>
References: <20110610143657.GF26441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110610143657.GF26441@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Jun 2011, Mark Brown wrote:

> > No, it's generally agreed that _all_ devices should return to full 
> > power during system resume -- even if they were runtime suspended 
> > before the system sleep.  This also is explained in the Documentation 
> > files.
> 
> What is the reasoning behind this agreement?  It's not immediately
> obvious why this is useful.

See section 6 of Documentation/power/runtime_pm.txt.

Alan Stern
