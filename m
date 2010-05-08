From: "Du, Alek" <alek.du@intel.com>
Subject: Re: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
 (WKOC_E) and disconnect (WKDISC_E)
Date: Sat, 8 May 2010 10:00:59 +0800
Message-ID: <1865303E0DED764181A9D882DEF65FB61A82A6DF26__2981.14030524648$1273284148$gmane$org@shsmsx502.ccr.corp.intel.com>
References: <20100507093200.28ecd63c@dxy2>
	<Pine.LNX.4.44L0.1005071106570.1804-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005071106570.1804-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>On Fri, 7 May 2010, Du, Alek wrote:
>
>> Alan,
>>
>> As I tested, with the second patch, after entering phy low power mode, the
>port cannot detect any USB devices that plugged in.
>
>Ooh, that's not good.  It almost violates the EHCI spec (see the last
>line on p.60 in table 4.4).

Ok, that's the new behavior that PHCD brings to us, It shouldn't a big deal if we
take care of the wakeup bits before PHCD, right? The spec may be modified if
PHCD become a normal feature to EHCI, just like why we have EHCI1.1 addendum
spec. (We have some ehci1.1 addendum patches that will submit soon, but the
PHCD is not in EHCI1.1 addendum currently)

>
>> I also confirm that after set PHCD flag, any write to PORTSC is illegal. (I have
>another patch will send out soon named "Clear PHCD before resuming",
>> but the patch is not related with this one)
>
>I'm afraid we are going to have to modify the wakeup bits in PORTSC
>after PHCD is set.  Can we clear PHCD, modify PORTSC, and then set PHCD
>again?

This is doable. It is confirmed by the HW designer, before accessing PORTSC, just
Clear PHCD. But we still need additional 5ms for the second time PHCD setting to
ensure it enter phy low power mode.

>
>> So it seems wakeup bits must set before set PHCD. So we may revise the
>flowchart a little bit, for example, if the HCD has hostpc,
>> then set the wakeup bits like before, if the HCD is the normal one, then go
>your new way?
>
>For normal HCDs, the wakeup bits don't matter when the controller is in
>D0.  Therefore we can continue to set them as before during bus or port
>suspend.
>
>But during controller suspend, if the controller isn't supposed to be
>remote-wakeup-enabled then we will need to clear the wakeup bits
>(and set them again during controller resume).  Will that work?

That should be ok. For Moorestown, the controller should always enable remote
wakeup, so that won't impact us.

>
>Alan Stern
