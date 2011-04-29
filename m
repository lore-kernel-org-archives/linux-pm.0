From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Generic clock
	manipulation rountines for runtime PM (v3)
Date: Fri, 29 Apr 2011 23:07:34 +0200
Message-ID: <201104292307.35070.rjw__47506.6565712497$1304111274$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104280258.34694.rjw@sisk.pl>
	<20110429205039.GB7497@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110429205039.GB7497@ponder.secretlab.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, April 29, 2011, Grant Likely wrote:
> On Thu, Apr 28, 2011 at 02:58:34AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, April 28, 2011, Colin Cross wrote:
> > > On Wed, Apr 27, 2011 at 2:48 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > +void pm_runtime_clk_remove(struct device *dev, const char *con_id)
> > > > +{
> > > > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > > > +       struct pm_clock_entry *ce;
> > > > +
> > > > +       if (!prd)
> > > > +               return;
> > > > +
> > > > +       mutex_lock(&prd->lock);
> > > > +
> > > > +       list_for_each_entry(ce, &prd->clock_list, node)
> > > Braces
> > 
> > No, this is correct as is.
> 
> The code is correct, but Colin's comment is valid.  Braces do make it
> easier for a reader to properly interpret the scope of large multiline
> blocks, even if it does resolve to a single statement.

OK, I'll add the braces.

Thanks,
Rafael
