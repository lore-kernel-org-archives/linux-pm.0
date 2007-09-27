From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC] QoS params patch
Date: Wed, 26 Sep 2007 21:05:15 -0700
Message-ID: <20070926210515.6725e745.randy.dunlap__26288.704670924$1190866073$gmane$org@oracle.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070927022440.GB25873@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070927022440.GB25873@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Sep 2007 11:24:40 +0900 Paul Mundt wrote:

> > +/* static helper functions */
> > +static s32 max_compare(s32 v1, s32 v2)
> > +{
> > +	if (v1 < v2)
> > +		return v2;
> > +	else
> > +		return v1;
> > +}
> > +
> > +static s32 min_compare(s32 v1, s32 v2)
> > +{
> > +	if (v1 < v2)
> > +		return v1;
> > +	else
> > +		return v2;
> > +}
> > +
> min()/max() instead?

Other code wants function pointers to the min & max functions.
That's why they are here AFAICT.


> > +/* assumes qos_lock is held */
> > +static void update_target(int i)
> > +{
> 'target' might be a more meaningful variable name.

Anything but 'i'.

---
~Randy
Phaedrus says that Quality is about caring.
