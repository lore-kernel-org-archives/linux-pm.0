From: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Subject: Re: [PATCH v4] PM: add statistics debugfs file for
 suspend	to ram
Date: Thu, 11 Aug 2011 01:55:47 +0530
Message-ID: <EB6073F1DF78F9439DFDCC701BC6466007B36A0D19__18299.4646639147$1313008012$gmane$org@bgsmsx502.gar.corp.intel.com>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0CCE@bgsmsx502.gar.corp.intel.com>
	<20110810194529.GA5590@suse.de>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0D12@bgsmsx502.gar.corp.intel.com>
	<20110810195854.GA5939@suse.de>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0D14@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <EB6073F1DF78F9439DFDCC701BC6466007B36A0D14@bgsmsx502.gar.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mansoor, Illyas" <illyas.mansoor@intel.com>, Greg KH <gregkh@suse.de>
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> 
> > On Thu, Aug 11, 2011 at 01:22:56AM +0530, Mansoor, Illyas wrote:
> > > static pm_message_t pm_transition;
> > > > > >
> > > > > > @@ -464,8 +465,12 @@ void dpm_resume_noirq(pm_message_t state)
> > > > > >  		mutex_unlock(&dpm_list_mtx);
> > > > > >
> > > > > >  		error = device_resume_noirq(dev, state);
> > > > > > -		if (error)
> > > > > > +		if (error) {
> > > > > > +			suspend_stats.failed_resume_noirq++;
> > > > > > +			dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > > > > > +			dpm_save_failed_dev(dev_name(dev));
> > > > >
> > > > > Please make these statistics conditionally enabled, so on a production
> > system
> > > > > If we need to disable these statistics code we should be able to do so.
> > > >
> > > > Why, are they taking time or space that is needed for something else?
> > > > What's the downside here of just not always having this enabled?
> > >
> > > Why have something that is not required/Used?
> >
> > Because someone might need it and rebuilding a kernel isn't possible on
> > lots of devices.
> 
> Agreed.
> 
> >
> > > Its only useful if DEBUGFS is configured anyways
> >
> > Almost all systems these days have debugfs enabled, so that's a moot
> > point.
> 
> We could do the same for this as well, since DEBUGFS is still a compile time
> Option even thou many enable it by default we don't make it part of the kernel
> isn't it.
> 

May be it's not worth debating on this one, I'm okay if it's part of the kernel as well.

-Illyas
