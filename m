From: Martin Wache <m.wache@gmx.net>
Subject: Re: Status of Regression/Bug 13407 adb trackpad
 disappears after suspend to ram?
Date: Mon, 28 Sep 2009 06:31:05 +0200
Message-ID: <4AC03C09.7090008__43919.2657395781$1254149488$gmane$org@gmx.net>
References: <4ABF5432.9020508@gmx.net> <200909271713.44719.rjw@sisk.pl>	
	<4ABFAA82.2040200@gmx.net> <1254108467.8421.3.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254108467.8421.3.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Benjamin Herrenschmidt schrieb:
> On Sun, 2009-09-27 at 20:10 +0200, Martin Wache wrote:
>> Hi,
>>
>> Rafael J. Wysocki schrieb:
>>
>>> A patch has been submitted which is reported to fix the issue:
>>>
>>> http://patchwork.kernel.org/patch/49462/
>>>
>>> Please test it as requested.
>>>
>> Thank you for the info :-)
>>
>> Unfortunately, applying the patch on top of 2.6.31 doesn't improve the 
>> situation for me, rather the opposite. Under X I get no reaction on any 
>>   keypress on the keyboard or movement on the trackpad. Even plugging in 
>> an USB mouse and keyboard didn't help, the usb port doesn't provide an 
>> power to the mouse (at least the led in the mouse doesn't light up).
>> Before X starts up the keyboard does respond, also the trackpad seems to 
>> be detected. Doing a suspend/resume cycle doesn't change the situation.
> 
> That looks like a different problem than the one I fixed. Is there an
> email thread or a bugzilla entry that describes the setup precisely, the
> symptoms, kernel logs etc... ?
> 
The USB not working was indeed a separate issue, I striped down my 
kernel config before building 2.6.31 and striped it down too much. After 
fixing the config the usb is again working.

What I don't really understand is that now after I fixed the usb kernel 
config and recompiled also the adb keyboard and trackpad are working again.
To test the original issue, I did several suspend/resume cycles and my 
trackpad is still working :-).
Without the patch the trackpad was almost never working after a 
suspend/resume cycle, so the adb trackpad issue seems to be fixed with 
your patch.
Thank you very much :-)

Bye,

Martin
