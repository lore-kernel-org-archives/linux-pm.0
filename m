From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC][PATCH 1/3] use new pm_ops in DRM drivers
Date: Thu, 3 Apr 2008 16:48:59 -0700
Message-ID: <200804031648.59630.jbarnes__30931.2852369205$1207266806$gmane$org@virtuousgeek.org>
References: <200804020207.40278.rjw@sisk.pl>
	<200804031150.55967.jbarnes@virtuousgeek.org>
	<1207259267.10388.334.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1207259267.10388.334.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 03, 2008 2:47 pm Benjamin Herrenschmidt wrote:
> On Thu, 2008-04-03 at 11:50 -0700, Jesse Barnes wrote:
> > +static struct pm_ops i915_pm_ops = {
> > +       .prepare = NULL, /* DRM core should prevent any new ioctls? */
> > +       .complete = NULL, /* required to re-enable DRM client requests
> > */
>
> The DRM core could definitely provide generic prepare & complete that
> sync'up with user space, making sure the command streams stop etc...

Yeah, that's what I had in mind.  I'll have to think a little harder about it 
though, I think there may be some driver specific stuff required here as 
well, which would mean a driver routine that calls into a core routine (both 
of which still need to be written :).

Jesse
