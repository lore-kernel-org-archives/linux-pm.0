From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 15:04:55 +0200
Message-ID: <200808271504.56824.rjw__45706.6839248457$1219842366$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<200808270128.16052.rjw@sisk.pl>
	<200808270955.12511.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808270955.12511.oliver@neukum.org>
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

On Wednesday, 27 of August 2008, Oliver Neukum wrote:
> Am Mittwoch 27 August 2008 01:28:15 schrieb Rafael J. Wysocki:
> > > This doesn't explain the original failure. Can you comment out the su=
pport
> > > for suspend/resume in the driver and try again?
> > =

> > With that commented out, I'm able to reproduce the failure. =A0With the=
 original
> > patch, I'm not.
> =

> Now we know a driver without support for suspend/resume breaks suspend and
> hibernate. We need to find out whether this is limited to btusb or everyt=
hing.

I'm quite confident it's specific to bluetooth, because I only need to turn
the bluetooth user space off, most importantly hcid, to make the problem go
away even without the patch (that is, without the patch I don't even have to
uload btusb before suspend if the bluetoot user land is not running).

> Can you test with anotherrrrr driver, like a mouse and remove suspend/res=
ume
> from usbhid? If this is specific to btusb we have a fix, if not, I am afr=
aid
> this has to be bisected.

Is that really necessary?

I can do that, but first I'll check if 2.6.26 is fine.

Thanks,
Rafael
