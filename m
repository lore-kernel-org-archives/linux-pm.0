From: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 09:55:11 +0200
Message-ID: <200808270955.12511.oliver__33568.4512545869$1219823902$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808262153.18240.oliver@neukum.org>
	<200808270128.16052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808270128.16052.rjw@sisk.pl>
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

Am Mittwoch 27 August 2008 01:28:15 schrieb Rafael J. Wysocki:
> > This doesn't explain the original failure. Can you comment out the supp=
ort
> > for suspend/resume in the driver and try again?
> =

> With that commented out, I'm able to reproduce the failure. =A0With the o=
riginal
> patch, I'm not.

Now we know a driver without support for suspend/resume breaks suspend and
hibernate. We need to find out whether this is limited to btusb or everythi=
ng.

Can you test with anotherrrrr driver, like a mouse and remove suspend/resume
from usbhid? If this is specific to btusb we have a fix, if not, I am afraid
this has to be bisected.

	Regards
		Oliver
