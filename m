From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
 callbacks (highest level)
Date: Sun, 2 Mar 2008 11:23:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803021123100.9430-100000__6556.6765646965$1204475301$gmane$org@netrider.rowland.org>
References: <200803021449.27834.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803021449.27834.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 Mar 2008, Rafael J. Wysocki wrote:

> Hi,
> 
> Below is a patch that introduces the separation of suspend and hibernation
> callbacks on the highest level, which is the PM core.  This patch is a result
> of a very recent work by Alex and me.
> 
> For now, we only take into account the callbacks necessary to replace the
> existing code, so we haven't introduced any substantially new callbacks.  The
> question is whether or not we'll need such callbacks and what purpose they
> may serve.
> 
> Moreover, we assume that the existing (legacy) ->suspend() and ->resume()
> callbacks will be used for bus types, device classes and device types that
> don't implement the new callbacks.  As a result, the patch doesn't introduce
> any visible functional changes.
> 
> It has been compilation tested on x86-64.
> 
> Comments welcome.

Where's the kerneldoc explaining the meaning of the new event codes and 
new methods?

Alan Stern
