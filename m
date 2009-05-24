From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM core: rename suspend and resume functions
Date: Sun, 24 May 2009 23:06:30 +0200
Message-ID: <200905242306.30415.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0905191051240.2646-100000@iolanthe.rowland.org>
	<aec7e5c30905210054q24c121dfj555e9029beb39686@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905210054q24c121dfj555e9029beb39686@mail.gmail.com>
Content-Disposition: inline
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 May 2009, Magnus Damm wrote:
> On Tue, May 19, 2009 at 11:53 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > This patch (as1241) renames a bunch of functions in the PM core.
> > Rather than go through a boring list of name changes, suffice it to
> > say that in the end we have a bunch of pairs of functions:
> >
> >        device_resume_noirq     dpm_resume_noirq
> >        device_resume           dpm_resume
> >        device_complete         dpm_complete
> >        device_suspend_noirq    dpm_suspend_noirq
> >        device_suspend          dpm_suspend
> >        device_prepare          dpm_prepare
> >
> > in which device_X does the X operation on a single device and dpm_X
> > invokes device_X for all devices in the dpm_list.
> >
> > In addition, the old dpm_power_up and device_resume_noirq have been
> > combined into a single function (dpm_resume_noirq).
> >
> > Lastly, dpm_suspend_start and dpm_resume_end are the renamed versions
> > of the former top-level device_suspend and device_resume routines.
> >
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Looks like a bigger step in the right direction. =)
> Applied on top of next-20090520, compiles fine on SuperH with
> sh7724_generic_defconfig.
> 
> Acked-by: Magnus Damm <damm@igel.co.jp>

Patch applied to the suspend-2.6 tree (linux-next branch).

Thanks,
Rafael
