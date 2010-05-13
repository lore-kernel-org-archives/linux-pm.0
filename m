From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:16:39 -0700
Message-ID: <1273785399.19100.98.camel__38197.5985983901$1273785540$gmane$org@c-dwalke-linux.qualcomm.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1273779394.19100.47.camel@c-dwalke-linux.qualcomm.com>
	<20100513194820.GA19722@srcf.ucam.org> <201005132311.26293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005132311.26293.rjw@sisk.pl>
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
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-13 at 23:11 +0200, Rafael J. Wysocki wrote:
> On Thursday 13 May 2010, Matthew Garrett wrote:
> > On Thu, May 13, 2010 at 12:36:34PM -0700, Daniel Walker wrote:
> > > On Thu, 2010-05-13 at 20:11 +0100, Matthew Garrett wrote:
> > > > See feature-removal-schedule.txt. So far we have no indication that it's 
> > > > going to be replaced, because nobody has actually suggested a working 
> > > > way to do this better. If we had a concrete implementation proposal for 
> > > > that then we'd be in a pretty different position right now.
> > > 
> > > Ok, feature-removal-schedule.txt applies to everything tho. What your
> > > saying is that if this interface only last a short time it might take 6
> > > months, if it last for a long time it would take longer. There's no easy
> > > way to know that Google is the only user after some amount of time
> > > passes.
> > 
> > If the interface is there for a long time, it's because we haven't come 
> > up with anything better. And if we haven't come up with anything better, 
> > the interface deserves to be there.
> 
> Moreover, the interface is already in use out-of-tree and that usage is
> actually _growing_, so we have a growing number of out-of-tree drivers that
> aren't megrgeable for this very reason.

Why can't we merge the drivers? Drivers are just drivers, they don't
need this to get merged. (They need it to work with Android)

Daniel
