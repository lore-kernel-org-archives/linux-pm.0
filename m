From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 23:40:21 +0200
Message-ID: <200707172340.23656.rjw__49817.5617460676$1184708094$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<87bqeag369.fsf@jbms.ath.cx>
	<Pine.LNX.4.64.0707171404330.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171404330.2467@asgard.lang.hm>
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
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 23:06, david@lang.hm wrote:
> On Tue, 17 Jul 2007, Jeremy Maitin-Shepard wrote:
> 
> > david@lang.hm writes:
> >
> > [snip]
> >
> >>>> * figure out which devices can wake up
> >>>> * put devices into low power states (wake-up devices are placed in the Dx
> >>>> states compatible with the wake capability, the others are powered off)
> >
> >> this can't be done by the image-saving kernel if that kernel doesn't know about
> >> the device.
> >
> > The image-saving kernel can be made to know about all of the "wake up"
> > devices; all other devices should have already been powered off by the
> > "hibernated" kernel.
> 
> not nessasarily.

More than that.  The hibernated kernel should not power off any devices,
because that is _wasteful_ (unless, of course, the powering off a device is the
only way to quiesce it).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
