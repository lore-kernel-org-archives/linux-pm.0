From: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 21:53:17 +0200
Message-ID: <200808262153.18240.oliver__4798.68239858678$1219780653$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<20080826114138.GI32522@suse.de> <200808262044.54445.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808262044.54445.rjw@sisk.pl>
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

Am Dienstag 26 August 2008 20:44:53 schrieb Rafael J. Wysocki:
> On Tuesday, 26 of August 2008, Stefan Seyfried wrote:
> > On Tue, Aug 26, 2008 at 12:10:08PM +0200, Rafael J. Wysocki wrote:
> > > > Good. Can you test what happens if you unplug the device while suspended
> > > > and hibernated?
> > > 
> > > It's built-in, I can't unplug it. :-)
> > 
> > Maybe you can disable it in the BIOS, but this might change the DSDT / other
> > system configuration, so it might break resume in other ways :-(
> 
> There is a switch that's supposed to disable the radio (rfkill or something).
> I used it to switch the radio off while the box was waking up from hibernation
> and kbluetooth didn't find the adapter after the resume.  After I've pressed
> the "radio off" button again, the bluetooth appears to be functional again.
> 
> However, this "radio off" button is shared between bluetooth and wireless
> (b43) and there are some surprising interactions.  Nothing seems to be broken,
> though.

This doesn't explain the original failure. Can you comment out the support
for suspend/resume in the driver and try again? The patch also fixes a
race in disconnect that you may be hitting.

	Regards
		Oliver
