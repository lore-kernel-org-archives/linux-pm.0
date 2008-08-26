From: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 11:43:19 +0200
Message-ID: <200808261143.20459.oliver__34256.0290745043$1219744172$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808251550.46303.oliver@neukum.org>
	<200808261136.05666.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808261136.05666.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Am Dienstag 26 August 2008 11:36:04 schrieb Rafael J. Wysocki:
> [Sorry for the delayed reply.]
> =

> On Monday, 25 of August 2008, Oliver Neukum wrote:
> > Am Montag 25 August 2008 13:54:31 schrieb Marcel Holtmann:
> > > Oliver, can you come up with a small test patch, that just kills all =
=A0
> > > URB when suspend and submits the interrupt ones at resume. Such a =A0
> > > patch might have to be merged for 2.6.27 if it fixes this problem.
> > =

> > Rafael,
> > =

> > this patch implemts suspend/resume for btusb and fixes a disconnect
> > problem. Does it help you?
> =

> Yes, the patch appears to help.
> =

> I haven't had a single crash since I applied it.  I'm going to test it a =
bit
> more today, though.

Good. Can you test what happens if you unplug the device while suspended
and hibernated?

	Regards
		Oliver
