From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 12:10:08 +0200
Message-ID: <200808261210.09665.rjw__5791.12372729487$1219745686$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<200808261136.05666.rjw@sisk.pl>
	<200808261143.20459.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808261143.20459.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 26 of August 2008, Oliver Neukum wrote:
> Am Dienstag 26 August 2008 11:36:04 schrieb Rafael J. Wysocki:
> > [Sorry for the delayed reply.]
> > =

> > On Monday, 25 of August 2008, Oliver Neukum wrote:
> > > Am Montag 25 August 2008 13:54:31 schrieb Marcel Holtmann:
> > > > Oliver, can you come up with a small test patch, that just kills al=
l =A0
> > > > URB when suspend and submits the interrupt ones at resume. Such a =
=A0
> > > > patch might have to be merged for 2.6.27 if it fixes this problem.
> > > =

> > > Rafael,
> > > =

> > > this patch implemts suspend/resume for btusb and fixes a disconnect
> > > problem. Does it help you?
> > =

> > Yes, the patch appears to help.
> > =

> > I haven't had a single crash since I applied it.  I'm going to test it =
a bit
> > more today, though.
> =

> Good. Can you test what happens if you unplug the device while suspended
> and hibernated?

It's built-in, I can't unplug it. :-)

Thanks,
Rafael
