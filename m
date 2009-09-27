From: Martin Wache <m.wache@gmx.net>
Subject: Re: Status of Regression/Bug 13407 adb trackpad
 disappears after suspend to ram?
Date: Sun, 27 Sep 2009 20:10:10 +0200
Message-ID: <4ABFAA82.2040200__26579.7950131402$1254149470$gmane$org@gmx.net>
References: <4ABF5432.9020508@gmx.net> <200909271713.44719.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909271713.44719.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Rafael J. Wysocki schrieb:

> A patch has been submitted which is reported to fix the issue:
> 
> http://patchwork.kernel.org/patch/49462/
> 
> Please test it as requested.
>
Thank you for the info :-)

Unfortunately, applying the patch on top of 2.6.31 doesn't improve the 
situation for me, rather the opposite. Under X I get no reaction on any 
  keypress on the keyboard or movement on the trackpad. Even plugging in 
an USB mouse and keyboard didn't help, the usb port doesn't provide an 
power to the mouse (at least the led in the mouse doesn't light up).
Before X starts up the keyboard does respond, also the trackpad seems to 
be detected. Doing a suspend/resume cycle doesn't change the situation.

I'm not sure if there was a miscompilation, I didn't do a "make clean", 
I just applied the patch and did a "make". Should this be enough? 
Compiling the whole kernel unfortunately takes quite a while on my iBook :-(
I will see if I can connect to the iBook via net and get some 
information on what is happening, or maybe I try to start it up without 
X. Would it help you if I send you the logs, etc? Which information 
would help you?

Thanks,

Martin
