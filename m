From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Sun, 30 Jan 2011 11:03:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101301100090.6500-100000__48941.6802222424$1296403498$gmane$org@netrider.rowland.org>
References: <201101300107.19389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101300107.19389.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 30 Jan 2011, Rafael J. Wysocki wrote:

> Hi,
> 
> This is something we discussed during the last Linux Plumbers Conference.
> 
> The problem appears to be that the same device may be used in different
> systems in different configurations such that actions necessary for the
> device's power management can vary from one system to another.  In those
> cases the drivers' power management callbacks are generally not sufficient,
> because they can't take the configuration of the whole system into account.
> 
> I think this issue may be addressed by adding objects that will represent
> power domains and will provide power management callbacks to be executed
> in addition to the device driver's PM callbacks, which is done by the patch
> below.
> 
> Please have a look at it and tell me what you think.

One thing about this implementation is slightly questionable.  The new
power_domain callbacks were added to the __weak platform PM routines,
which means they will have to be included in every overriding routine
provided by a platform imiplementation.

Would it be better to separate these things?  Have the power_domain 
callbacks occur in a static outer function which then calls a public 
__weak inner function that can be overridden?

Alan Stern
