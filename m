From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] PM: kill dev_pm_ops platform warning for now
Date: Mon, 10 Aug 2009 09:45:42 -0700
Message-ID: <20090810164542.GA28405__40820.9071997136$1249922999$gmane$org@suse.de>
References: <20090807083430.31389.98825.sendpatchset@rx1.opensource.se>
	<200908081516.24018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908081516.24018.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 08, 2009 at 03:16:23PM +0200, Rafael J. Wysocki wrote:
> On Friday 07 August 2009, Magnus Damm wrote:
> > From: Magnus Damm <damm@igel.co.jp>
> > 
> > Remove the platform device runtime dev_pm_ops warning
> > for now. No point in upsetting users of non-rc kernels.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> Thanks for the patch, I modified the changelog a bit.
> 
> Greg, do you agree with the patch below?

Yes, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch and forward it on.

Or do you need me to forward it?

thanks,

greg k-h
