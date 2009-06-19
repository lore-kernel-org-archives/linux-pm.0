From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [ath5k-devel]  PCI hotplug v.s. suspend
Date: Fri, 19 Jun 2009 09:34:20 +0100
Message-ID: <4A3B4D8C.6010002__14244.930962059$1245400534$gmane$org@tuffmail.co.uk>
References: <Pine.LNX.4.44L0.0906181437090.3129-100000@netrider.rowland.org>
	<4A3AAF0A.9020707@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3AAF0A.9020707@tuffmail.co.uk>
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
Cc: Bob Copeland <me@bobcopeland.com>, ath5k-devel@venema.h4ckr.net, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Jenkins wrote:
> Alan Stern wrote:
>   
>> On Thu, 18 Jun 2009, Alan Jenkins wrote:
>>
>>   
>>     
>>> Unfortunately this makes it worse.  My eeepc-laptop hacks are now in
>>> wireless-testing.  If I apply the above patch to wireless-testing and
>>> "remove" the device while suspended, I get a soft hang on resume. 
>>>     
>>>       
>> Is this different from the behavior without the patch?  (I don't see 
>> how it could be.)
>>   
>>     
>
> Ow.  No, the free_irq patch doesn't cause this bug.  I missed testing
> this case after adding a workaround for an even more obscure issue :-(.
>   

I tried an earlier version without the problem workaround.  Bob's
suggested patch to remove the free_irq() on suspend works fine.  It
fixes the WARNING when the device is removed during suspend, and it
still works if the device is not removed during suspend.

Alan
