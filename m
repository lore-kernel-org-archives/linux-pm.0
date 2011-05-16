From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/6][RFC] PM / Domains: Support for multiple
	generic power domain states
Date: Mon, 16 May 2011 20:29:18 +0200
Message-ID: <201105162029.18615.rjw__3815.63830092109$1305573590$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105160138.10431.rjw@sisk.pl>
	<87sjsfdklw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjsfdklw.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Monday, May 16, 2011, Kevin Hilman wrote:
> Hi Rafael,
> 
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Allow the generic power domains support code to handle power
> > domains with multiple states.  
> 
> Thanks!

No problem. :-)

> Before I even had the time to respond to you about my previous request
> for this kind of feature, you've already implmented it. :)  

Well, I had the idea how to implement it right after I had replied to
your previous message.  The only problem was to find the time to actually
prepare a patch.

> > Replace the .power_down_ok()
> > callback in struct dev_power_governor with a new callback
> > .choose_state() that will return the number of the state to put the
> > power domain into.  Add new fields nr_states and current_state to
> > struct generic_power_domain with the assumption that state 0 will be
> > the full power state and states 1 through (nr_states - 1) will be low
> > power.  
> > Replace power domain callbacks .power_off() and .power_on()
> > with a single .set_state() callback taking the number of the state
> > to put the power domain into as its second argument.  Add a new
> > generic power domain callback .power_off_state() (taking a state
> > number as its second argument) allowing the core to check if
> > device runtime PM callbacks need to be executed before putting the
> > given power domain into the given state.  Modify the core power
> > domains code and the ARM shmobile platform code to take all of the
> > above changes into account.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks!

> This looks like a better starting point for more complicated hardware.

I agree.

Rafael
