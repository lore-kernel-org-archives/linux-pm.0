From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] PM: add statistics debugfs file for
 suspend	to ram
Date: Fri, 12 Aug 2011 09:04:24 +0200
Message-ID: <20110812070424.GA5249__41752.9854029$1313132918$gmane$org@ucw.cz>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0CCE@bgsmsx502.gar.corp.intel.com>
	<20110810194529.GA5590@suse.de>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0D12@bgsmsx502.gar.corp.intel.com>
	<20110810195854.GA5939@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110810195854.GA5939@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, "Liu, ShuoX" <shuox.liu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2011-08-10 12:58:54, Greg KH wrote:
> On Thu, Aug 11, 2011 at 01:22:56AM +0530, Mansoor, Illyas wrote:
> > static pm_message_t pm_transition;
> > > > >
> > > > > @@ -464,8 +465,12 @@ void dpm_resume_noirq(pm_message_t state)
> > > > >  		mutex_unlock(&dpm_list_mtx);
> > > > >
> > > > >  		error = device_resume_noirq(dev, state);
> > > > > -		if (error)
> > > > > +		if (error) {
> > > > > +			suspend_stats.failed_resume_noirq++;
> > > > > +			dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > > > > +			dpm_save_failed_dev(dev_name(dev));
> > > >
> > > > Please make these statistics conditionally enabled, so on a production system
> > > > If we need to disable these statistics code we should be able to do so.
> > > 
> > > Why, are they taking time or space that is needed for something else?
> > > What's the downside here of just not always having this enabled?
> > 
> > Why have something that is not required/Used?
> 
> Because someone might need it and rebuilding a kernel isn't possible on
> lots of devices.

Yeah, and someone may need tetris, lets put  it into kernel and enable
unconditionaly :-(.

Really, this is just patch to provide dmesg subset, because someone is
cool enough to hack kernel, but will not just use grep.

The patch should be just dropped. Use perf or dmesg parsing to collect
data; fix printks() to be easier to grep for if needed.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
