From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
 and fixes
Date: Thu, 20 Mar 2008 20:55:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803202053270.11234-100000__16771.7381417335$1206061062$gmane$org@netrider.rowland.org>
References: <200803210122.44188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210122.44188.rjw@sisk.pl>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:

> The original code executed platform_pci_choose_state() first, if defined, and
> if that succeeded, it just returned the result.  You put
> platform_pci_choose_state() under the switch(). :-)

For FREEZE and QUIESCE, is there ever any reason to leave D0?  These 
calls are documented as not requiring (and not desiring!) any change in 
power level.

> Consequently, the 'state' argument would simply be unnecessary (and in fact
> it's ignored if platform_pci_choose_state() is defined).

It should not be ignored, for the reason given above.

Alan Stern
