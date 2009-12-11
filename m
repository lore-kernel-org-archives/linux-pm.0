From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix kernel-doc notation
Date: Fri, 11 Dec 2009 22:08:29 +0100
Message-ID: <200912112208.29241.rjw__15623.3264053755$1260565745$gmane$org@sisk.pl>
References: <1258877637.4495.45.camel@ht.satnam>
	<20091211120259.82de239d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091211120259.82de239d.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, Jaswinder Singh Rajput <jaswinder@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 11 December 2009, Randy Dunlap wrote:
> On Sun, 22 Nov 2009 13:43:57 +0530 Jaswinder Singh Rajput wrote:
> 
> > 
> > Fix the following htmldocs warnings:
> > 
> >   Warning(drivers/base/power/main.c:249): No description found for parameter 'master'
> >   Warning(drivers/base/power/main.c:249): Excess function parameter 'slave' description in 'device_pm_wait_for_slaves'
> >   Warning(drivers/base/power/main.c:292): No description found for parameter 'master'
> >   Warning(drivers/base/power/main.c:292): Excess function parameter 'slave' description in 'device_pm_check_slaves'
> > 
> > Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Randy Dunlap <randy.dunlap@oracle.com>
> 
> What tree was this for?
> I guess it's not needed now, I can't find these functions..

It was on top of the async suspend/resume patches that Linus has rejected.

Rafael
