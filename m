From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_v4=5D_PM=3A_add_statistics_deb?=
 =?iso-8859-1?q?ugfs_file_for_suspend=09to_ram?=
Date: Fri, 12 Aug 2011 09:13:34 +0200
Message-ID: <201108120913.35046.rjw__25490.6345428482$1313133226$gmane$org@sisk.pl>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
	<20110810195854.GA5939@suse.de> <20110812070424.GA5249@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110812070424.GA5249@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, "Liu, ShuoX" <shuox.liu@intel.com>, Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 12, 2011, Pavel Machek wrote:
> On Wed 2011-08-10 12:58:54, Greg KH wrote:
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
> > > > > Please make these statistics conditionally enabled, so on a production system
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
> Yeah, and someone may need tetris, lets put  it into kernel and enable
> unconditionaly :-(.
> 
> Really, this is just patch to provide dmesg subset, because someone is
> cool enough to hack kernel, but will not just use grep.
> 
> The patch should be just dropped.

And what's the _technical_ reason?

Do you think it's generally wrong to have two different ways of getting
the same debug information from the kernel?

Really, the truth is that suspend debugging is still way too difficult
for the majority of users and I don't quite see a reason to drop patches
that may improve the situation in this area.

Thanks,
Rafael
