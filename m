From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Thu, 28 Aug 2008 00:33:06 +0200
Message-ID: <200808280033.08006.rjw__49962.0902738117$1219876387$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<200808271509.06097.oliver@neukum.org>
	<200808271528.48685.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808271528.48685.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-usb@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 27 of August 2008, Rafael J. Wysocki wrote:
> On Wednesday, 27 of August 2008, Oliver Neukum wrote:
> > Am Mittwoch 27 August 2008 15:04:55 schrieb Rafael J. Wysocki:
> > > I'm quite confident it's specific to bluetooth, because I only need to turn
> > > the bluetooth user space off, most importantly hcid, to make the problem go
> > > away even without the patch (that is, without the patch I don't even have to
> > > uload btusb before suspend if the bluetoot user land is not running).
> > 
> > But do you use any other usb driver without support for suspend/resume?
> 
> Well, probably not.
> 
> I'll check the hid, then.

I couldn't reproduce the breakage with suspend/resume support removed from
usbhid.

Let's just say it's related to BT, since your patch evidently fixes the problem
for me and I have just no reason to believe it's anything else than BT.

Thanks,
Rafael
