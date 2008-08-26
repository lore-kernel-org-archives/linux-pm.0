From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch]full runtime power management for usbhid
Date: Tue, 26 Aug 2008 16:28:49 +0200
Message-ID: <20080826142848.GB5496__46961.4837937572$1219761107$gmane$org@ucw.cz>
References: <200808261139.14410.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808261139.14410.oliver@neukum.org>
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
Cc: jkosina@suse.cz, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> this patch enables full runtime power management for usbhid.
> Currently usbhid supports autosuspend only upon open and close. Thus
> it is useless for devices which are always opened, such as keyboards
> and mice. This patch enables the use of remote wakeup for devices that
> support it.
> 
> It suspends idle usb hid devices after a timeout if possible unless
> 
> - hiddev has opened the device
> - error handling is under way
> - a key is being held down
> (keyboards don't signal remote wakeup upon release of a key)
> - an led is active on the device
> (leds use too much power for a suspend device to keep lit -
> this can be overridden with a module parameter)

Hmm... so numlock now costs ~3W... perhaps we should be defaulting to
numlock=off, again?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
