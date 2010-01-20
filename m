From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
 for disabling device run-time PM
Date: Wed, 20 Jan 2010 10:09:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001201005380.1672-100000__34076.5411653139$1264000238$gmane$org@iolanthe.rowland.org>
References: <201001192132.26765.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001192132.26765.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Jan 2010, Rafael J. Wysocki wrote:

> > Why change the name from "level" to "runtime"?
> 
> Because it wouldn't be really obvious what "level" applied to.  For example,
> some people might expect the values of "level" to correspond to PCI power
> states for PCI devices and so on, so it might turn out to be confusing. 

But is the name "runtime" any clearer?  Especially to people who have 
never come across the phrase "runtime power management"?

Does anybody have a suggestion for a better attribute name?

Alan Stern
