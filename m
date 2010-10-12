From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v7] power: introduce library for
	device-specific OPPs
Date: Wed, 13 Oct 2010 01:25:14 +0200
Message-ID: <201010130125.14604.rjw__32237.9714264118$1286926039$gmane$org@sisk.pl>
References: <[PATCH] power: introduce library for device-specific OPPs>
	<4CB32675.1090205@ti.com> <201010120008.16388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010120008.16388.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Paul <paulmck@linux.vnet.ibm.com>, l-a <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 12, 2010, Rafael J. Wysocki wrote:
> On Monday, October 11, 2010, Nishanth Menon wrote:
> > Rafael J. Wysocki had written, on 10/09/2010 05:59 PM, the following:
> > [...]
> > >>
> > >> Signed-off-by: Nishanth Menon <nm@ti.com>
> > > 
> > > OK
> > > 
> > > Your error messages are a bit inconsistent (e.g. some of them print the
> > > error code while others don't), but I guess I can fix that up.
> > Thanks a bunch.
> > > 
> > > Still, to apply the patch I need a copyright notice for the doc too.
> > oops..
> > (C) 2009-2010 Nishanth Menon <nm@ti.com>, Texas Instruments Incorporated
> > Does this help?
> 
> Yes, it does.
> 
> > or would you like me to post a v8 as well?
> 
> That shouldn't be necessary.

The patch has been applied to suspend-2.6/linux-next at:

http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commit;h=56149b574181d98aedf97f1f2d91d05ab261db41

with minor changes around the error messages.  Please double check if everything
is correct.

Thanks,
Rafael
