From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 25 Aug 2008 13:55:50 +0200
Message-ID: <A990FF09-40FE-40B4-B0AA-C89827D1A559__16800.2118509778$1219665520$gmane$org@holtmann.org>
References: <200808221520.19791.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251337.16076.rjw@sisk.pl>
	<200808251353.12590.oliver@neukum.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808251353.12590.oliver@neukum.org>
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

>> Since the bluetooth adapter in this box is apparently handled by  
>> btusb, I'm
>> suspecting the problem may be related to it or to the USB subsystem  
>> (ehci-hcd
>> in particular).  I'm going to debug it further, but if you have any  
>> ideas to
>> try, I'll appreciate any help.
>
> btusb in current git doesn't implement suspend/resume. Thus the  
> driver will be
> unbound. Possibly the bluetooth subsystem cannot stand that while  
> suspended.

that should work. It then really looks like a bug. Something more  
weird must be going on here.

Regards

Marcel
