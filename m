From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 08 Sep 2008 22:49:27 +0200
Message-ID: <1220906968.11655.7.camel__8516.55615629188$1220907197$gmane$org@californication>
References: <200808221520.19791.oliver@neukum.org>
	<200808271528.48685.rjw@sisk.pl> <200808280033.08006.rjw@sisk.pl>
	<200808280917.57020.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808280917.57020.oliver@neukum.org>
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
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Oliver,

> > I couldn't reproduce the breakage with suspend/resume support removed from
> > usbhid.
> > 
> > Let's just say it's related to BT, since your patch evidently fixes the problem
> > for me and I have just no reason to believe it's anything else than BT.
>
> Very good.
> 
> here it is again. You may need to cut the USB bits depending
> on which tree you want to apply it to.

do we have a version that could be applied to 2.6.27-rc5, because the
patch depends on unmerged USB stuff. I tend to leave this for 2.6.28 for
now.

Regards

Marcel
