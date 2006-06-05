From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 0/6] PM_EVENT_PRETHAW
Date: Mon, 5 Jun 2006 09:36:07 -0700
Message-ID: <200606050936.08034.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200605261719.57601.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060527163837.GE4242@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Following this message will be patches adding the new PRETHAW event,
so that drivers can make sure that swsusp doesn't put hardware into
bogus states before resuming.

As previously discussed, this is needed by drivers which examine the
hardware state during resume() methods ... notably, USB controller
drivers, which expect to see true suspend states in order to handle
remote wakeup, but currently break with swsusp.  Only two states are
valid in resume():  after hardware reset, or else the state that
suspend() left it in.  PRETHAW allows drivers to force the former.

In sequence, the patches are:

 - prethaw-misc.patch ... fixes code that's currently broken/dubious
   so that it won't care about the new message (and is thus more or
   less mergeable regardless of the rest of these patches)

 - prethaw-header.patch ... defines the new event and its message

 - prethaw-fw.patch ... IDE and (dumb) PCI can handle it simplistically

 - prethaw-video.patch ... likewise, but this is per-driver not at the
   framework level

 - prethaw-usb.patch ... fixing various "swsusp resume fails if the
   HCD is statically linked" bugs

 - prethaw-core.patch ... updating the pm core to issue PRETHAW
   events, handling for which which the previous patches added.

Yes, it might be worth splitting some of those driver patches out into
patch-per-driver format.  Yes, I _did_ look at a couple hundred drivers
(grr) to see what needed changing ... darn few drivers treat suspend() as
anything other than PM_EVENT_SUSPEND.

- Dave
