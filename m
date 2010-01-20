From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
	for disabling device run-time PM
Date: Wed, 20 Jan 2010 22:09:29 +0100
Message-ID: <201001202209.29207.rjw__21695.126038003$1264021784$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001201005380.1672-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001201005380.1672-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 January 2010, Alan Stern wrote:
> On Tue, 19 Jan 2010, Rafael J. Wysocki wrote:
> 
> > > Why change the name from "level" to "runtime"?
> > 
> > Because it wouldn't be really obvious what "level" applied to.  For example,
> > some people might expect the values of "level" to correspond to PCI power
> > states for PCI devices and so on, so it might turn out to be confusing. 
> 
> But is the name "runtime" any clearer?  Especially to people who have 
> never come across the phrase "runtime power management"?
> 
> Does anybody have a suggestion for a better attribute name?

Apparently not, but I can try. ;-)

* status

* power (power/power looks weird, but the values would make sense)

* control

No more ideas for now.

Rafael
