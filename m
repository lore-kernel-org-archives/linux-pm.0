From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] QoS params patch
Date: Thu, 27 Sep 2007 08:37:33 -0700
Message-ID: <20070927153733.GF25718__26287.7240697437$1190907555$gmane$org@linux.intel.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070927022440.GB25873@linux-sh.org>
	<20070926210515.6725e745.randy.dunlap@oracle.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070926210515.6725e745.randy.dunlap@oracle.com>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2007 at 09:05:15PM -0700, Randy Dunlap wrote:
> On Thu, 27 Sep 2007 11:24:40 +0900 Paul Mundt wrote:
> 
> > > +/* static helper functions */
> > > +static s32 max_compare(s32 v1, s32 v2)
> > > +{
> > > +	if (v1 < v2)
> > > +		return v2;
> > > +	else
> > > +		return v1;
> > > +}
> > > +
> > > +static s32 min_compare(s32 v1, s32 v2)
> > > +{
> > > +	if (v1 < v2)
> > > +		return v1;
> > > +	else
> > > +		return v2;
> > > +}
> > > +
> > min()/max() instead?
> 
> Other code wants function pointers to the min & max functions.
> That's why they are here AFAICT.
> 
> 
> > > +/* assumes qos_lock is held */
> > > +static void update_target(int i)
> > > +{
> > 'target' might be a more meaningful variable name.
> 
> Anything but 'i'.

The 'i' is gone.  Will post new patch later today.

--mgross
