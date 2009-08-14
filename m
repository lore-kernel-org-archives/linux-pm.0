From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH update 2x] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 16)
Date: Fri, 14 Aug 2009 19:19:07 +0200
Message-ID: <200908141919.07492.rjw__44849.7752579444$1250270353$gmane$org@sisk.pl>
References: <200908081625.57333.rjw@sisk.pl> <200908132256.42941.rjw@sisk.pl>
	<aec7e5c30908140208j1498c134j46bef043f60f6c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30908140208j1498c134j46bef043f60f6c55@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Magnus Damm wrote:
> On Fri, Aug 14, 2009 at 5:56 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Introduce core framework for run-time PM of I/O devices (rev. 16)
> >
> > Introduce a core framework for run-time power management of I/O
> > devices.  Add device run-time PM fields to 'struct dev_pm_info'
> > and device run-time PM callbacks to 'struct dev_pm_ops'.  Introduce
> > a run-time PM workqueue and define some device run-time PM helper
> > functions at the core level.  Document all these things.
> >
> > Special thanks to Alan Stern for his help with the design and
> > multiple detailed reviews of the pereceding versions of this patch
> > and to Magnus Damm for testing feedback.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> I've now tested v16 with my SuperH Mobile platform device Runtime PM
> implementation. All seems fine and my patches for patches for drivers
> such as i2c master, fbdev, v4l2 and uio behave as expected.
> 
> Acked-by: Magnus Damm <damm@igel.co.jp>
> 
> The patch "PM: Runtime PM v15 - Platform Device Bus Support" works
> well with v16 and does not need any update.

Thanks for the ACK, but I have one more update to the patch.  Namely, I've
decided to change the return value of the ->runtime_idle() callback to int
as a result of the recent discussion on the PCI runtime PM patch from Matthew.

I'll post the updated patch in a little while.

Thanks,
Rafael
