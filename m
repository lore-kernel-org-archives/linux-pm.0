From: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 25 Aug 2008 13:53:10 +0200
Message-ID: <200808251353.12590.oliver__21912.9604324282$1219665384$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251337.16076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808251337.16076.rjw@sisk.pl>
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

Am Montag 25 August 2008 13:37:14 schrieb Rafael J. Wysocki:
> Since the bluetooth adapter in this box is apparently handled by btusb, I=
'm
> suspecting the problem may be related to it or to the USB subsystem (ehci=
-hcd
> in particular). =A0I'm going to debug it further, but if you have any ide=
as to
> try, I'll appreciate any help.

btusb in current git doesn't implement suspend/resume. Thus the driver will=
 be
unbound. Possibly the bluetooth subsystem cannot stand that while suspended.

	Regards
		Oliver
