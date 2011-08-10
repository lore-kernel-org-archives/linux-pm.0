From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v4] PM: add statistics debugfs file for
 suspend	to ram
Date: Wed, 10 Aug 2011 12:45:29 -0700
Message-ID: <20110810194529.GA5590__21172.9731680409$1313005621$gmane$org@suse.de>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B847F42F9@shsmsx502.ccr.corp.intel.com>
	<EB6073F1DF78F9439DFDCC701BC6466007B36A0CCE@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <EB6073F1DF78F9439DFDCC701BC6466007B36A0CCE@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10, 2011 at 11:30:40PM +0530, Mansoor, Illyas wrote:
> > +struct suspend_stats suspend_stats;
> >  static DEFINE_MUTEX(dpm_list_mtx);
> >  static pm_message_t pm_transition;
> > 
> > @@ -464,8 +465,12 @@ void dpm_resume_noirq(pm_message_t state)
> >  		mutex_unlock(&dpm_list_mtx);
> > 
> >  		error = device_resume_noirq(dev, state);
> > -		if (error)
> > +		if (error) {
> > +			suspend_stats.failed_resume_noirq++;
> > +			dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > +			dpm_save_failed_dev(dev_name(dev));
> 
> Please make these statistics conditionally enabled, so on a production system
> If we need to disable these statistics code we should be able to do so.

Why, are they taking time or space that is needed for something else?
What's the downside here of just not always having this enabled?

greg k-h
