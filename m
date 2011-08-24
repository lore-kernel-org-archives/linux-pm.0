From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2 v2] sh-sci / PM: Use power.irq_safe
Date: Wed, 24 Aug 2011 22:52:24 +0200
Message-ID: <201108242252.25098.rjw__36590.2311671109$1314219095$gmane$org@sisk.pl>
References: <201108202131.19479.rjw@sisk.pl> <201108212111.45012.rjw@sisk.pl>
	<20110824053317.GC26391@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110824053317.GC26391@linux-sh.org>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 24, 2011, Paul Mundt wrote:
> On Sun, Aug 21, 2011 at 09:11:44PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Since sci_port_enable() and sci_port_disable() may be run with
> > interrupts off and they execute pm_runtime_get_sync() and
> > pm_runtime_put_sync(), respectively, the SCI device's
> > power.irq_safe flags has to be used to indicate that it is safe
> > to execute runtime PM callbacks for this device with interrupts off.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Not sure how you want this one handled. Did you simply want to roll this
> in with your other patch with my Acked-by, or should I be taking this
> through my tree already regardless of the 1/2 patch?

I'd prefer to push it through my tree, if you don't mind.  Magnus has
already acked it for me, hopefully that's OK?

Rafael
