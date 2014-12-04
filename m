From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: S0iX Ultra Low Power States
Date: Thu, 4 Dec 2014 11:25:29 -0800
Message-ID: <20141204112529.72e54a57@kcaccard-desk.amr.corp.intel.com>
References: <54747B59.2080503@secunet.com>
	<20141125101359.088cdacf@kcaccard-desk.amr.corp.intel.com>
	<54770FF3.4000809@secunet.com>
	<54803096.6070807@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46379 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbaLDTZa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Dec 2014 14:25:30 -0500
In-Reply-To: <54803096.6070807@secunet.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, 4 Dec 2014 10:59:50 +0100
Dennis Wassenberg <dennis.wassenberg@secunet.com> wrote:

> Hi Kristen,
> 
> Now I am investigating on an other device (Microsoft Surface Pro 3).
> There I followed your instructions but without success. Even powertop
> assumes that everything is tuned for low power.
> 
> This device takes 2.5 Watt in freeze mode. So I assume that the S0i3
> state was not entered automatically. Is there any possibility to check
> which precondition is not satisfied? Or can I force the system to enter
> S0iX states?
> 
> Thank you & best regards,
> Dennis

Hi Dennis,
Why don't you do this:

(start with screen on, all external devices unplugged)

# powertop --auto-tune
# xset dpms force off; powertop --html --time 120; xset dpms force on

and send me the powertop.html output files.

BTW - I don't want to be pessimistic here, but you do realize the
surface pro was designed for windows and as such is unlikely to have
firmware which plays well with Linux.  But you can always try I suppose.

Kristen
 
> 
> On 27.11.2014 12:50, Dennis Wassenberg wrote:
> > Hi Kristen,
> > 
> > thank you for these hints. Especially these regarding PCIe endpoint
> > devices. I found that some of these was configured to be always on which
> > prevents the system from entering the S0iX states. After changing this
> > the power consumption reduced to approximately 0.5 Watt.
> > 
> > Thank you & best regards,
> > 
> > Dennis
> > 
> > On 25.11.2014 19:13, Kristen Carlson Accardi wrote:
> >> On Tue, 25 Nov 2014 13:51:37 +0100
> >> Dennis Wassenberg <dennis.wassenberg@secunet.com> wrote:
> >>
> >>> Hi,
> >>>
> >>> I would like to know more about the Linux power management in
> >>> correlation to the Intel S0iX Ultra Low Power States.
> >>>
> >>> Systems which have a Windows 8 Logo must support Connected Standby (or
> >>> InstantGo, however it is called). One of the requirements getting this
> >>> logo is that the ACPI firmware must not provide an S3 object in the root
> >>> of the namespace. This means that Linux can not use the S3 mode.
> >>>
> >>> To archive a very low power consumption Microsoft uses the Ultra Low
> >>> Power States S0i1 and S0i3. Is there a way to use these low power states
> >>> in linux for Haswell/LynxPoint or Broadwell/Skylake platforms?
> >>>
> >>> I read something about these states. Such that they can be activated
> >>> automatically but there are some preconditions (e.g. certain IO devices
> >>> have to put into a low power state, graphics off, only one CPU online,
> >>> ...). If I enter the S1 Low Power State (with additional
> >>> disable_nonboot_cpus) all of these preconditions should be fulfilled?!
> >>> But I can not observe that the there is a power consumption less than 1
> >>> Watt.
> >>>
> >>> Thank you & Best regards,
> >>>
> >>> Dennis
> >>
> >> Hi,
> >> On haswell ULT and Broadwell ULT these states can be entered as part of
> >> Linux's normal Idle flow if some preconditions are met.  You should run
> >> powertop to ensure that all devices are tuned for low power.  The
> >> embedded display must be off. (no external display connected).  You
> >> should confirm that all PCIe endpoint devices on your platform support
> >> ASPM and L1 substates (using lspci).  If they do not, you must ensure
> >> they are in D3.  You should kill or freeze any processes that frequently
> >> wake in order to improve your average battery life.  You can use
> >> powertop or turbostat to confirm entry into pc8/pc9/pc10.
> >>
> >> Good luck.
> >> Kristen
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

