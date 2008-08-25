From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rft]autosuspend for btusb
Date: Mon, 25 Aug 2008 13:51:30 +0200
Message-ID: <72EBACB5-155E-4F42-9852-886AB6B10417__4874.58735374293$1219665254$gmane$org@holtmann.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251243.47569.oliver@neukum.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808251243.47569.oliver@neukum.org>
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
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Oliver,

>>>> Please explain the tx_in_flight stuff to me. It looks unneeded  
>>>> since we
>>>> anchor all TX URBs anyway.
>>>
>>> The completion of an URB may happen after the autosuspend timeout  
>>> passed.
>>> But we cannot use the pm counters as they are not accessible in  
>>> interrupt.
>>> Hence we must maintain a counter ourselves.
>>
>> Can we not just check the number of URBs in the anchor? I am against
>> just duplicating a counter, but then lets call it it what it is to  
>> make
>> it gets not misused. It is a purely a PM counter.
>>
>
> An excellent suggestion allowing major simplifications. This version  
> works
> for me. It required an extension of the anchor API, so it obsoletes
> the split-up you've done. Therefore the whole thing comes as a big  
> patch
> against rc4, easy to test.

I will break up the patch into pieces. However right now I am missing  
my beloved test machine since I am traveling. So everybody reporting  
success or failure would be nice.

Can you break out the USB anchor extensions and make sure they get  
merged into 2.6.28 in an early stage of the merge window. It really  
wanna get all of this stuff into the next kernel release. Finally we  
are getting somewhere with this driver and can kill the broken hci_usb.

Regards

Marcel
