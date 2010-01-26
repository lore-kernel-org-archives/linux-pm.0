From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
	suspend/resume	if KMS is used
Date: Tue, 26 Jan 2010 15:17:27 +0100
Message-ID: <20100126141726.GA1437__506.602010182355$1264516177$gmane$org@ucw.cz>
References: <201001240055.59479.rjw@sisk.pl> <201001252217.39778.rjw@sisk.pl>
	<20100125212720.7d3af280@lxorguk.ukuu.org.uk>
	<201001252254.37635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001252254.37635.rjw@sisk.pl>
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
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon 2010-01-25 22:54:37, Rafael J. Wysocki wrote:
> On Monday 25 January 2010, Alan Cox wrote:
> > > > But in that case we should be able to disable the VT switch disable
> > > > path; we just have to check each driver as it's loaded.
> > > 
> > > OK, what the right sequence of checks would be in that case and where to place
> > > them?
> > 
> > Why are we even driving a vt switch direct from the suspend/resume
> > logic ? The problem starts there. If it was being handled off the device
> > suspend/resume method then there wouldn't be a mess to start with ?
> > 
> > Start at the beginning
> > 
> > - Why do we switch to arbitarily chosen 'last vt'
> > - Why isn't vt related suspend/resume handled by the device
> 
> Well, that was added long ago as a workaround for some problems people
> reported (presumably).  I've never looked at that before, so I can't really
> tell why someone did it this particular way.

As X drives hardware, it is/was neccessary to get control out of X and
console switch was convenient.

Note that it needs to happen with userland still active -- before
freezer.

And yes, it should be per-driver these days.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
