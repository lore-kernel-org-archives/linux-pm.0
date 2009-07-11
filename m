From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: 2 bugs related to suspend to disk
Date: Sat, 11 Jul 2009 16:38:35 +0200
Message-ID: <4A58A3EB.9040006__12734.3980865136$1247323186$gmane$org@gmail.com>
References: <4A199A7A.3010705@gmail.com> <200905252331.02488.rjw@sisk.pl>
	<4A1D9A4C.4000600@gmail.com> <200905272247.29098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905272247.29098.rjw@sisk.pl>
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
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki pisze:
> On Wednesday 27 May 2009, Marcin Slusarz wrote:
>> Rafael J. Wysocki wrote
>>> On Monday 25 May 2009, Marcin Slusarz wrote:
>>>> Rafael J. Wysocki wrote:
>>>>> On Sunday 24 May 2009, Marcin Slusarz wrote:
>>>>>> Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>
>>>>>>>> 2) "s2disk" (from suspend-0.8) suspends, but doesn't resume (and I need to mkswap && swapon -a later)
>>>>>>>>
>>>>>>> I'm afraid we need more details here. Is "resume" binary being ran?
>>>>>> Excellent question ;) - I didn't know it has to. I'll try to setup
>>>>>> initramfs tomorrow.
>>>>>>
>>>>>> Thanks and sorry for the noise!
>>>>> However, the issue reported as 1) is not really a noise IMO. :-)
>>>>>
>>>>> Can you please attach a full dmesg output containing these messages?
>>>> I've uploaded .config, dmesg (BUG was not saved) and 2 pictures of
>>>> screen just before power loss to http://www.kadu.net/~joi/kernel/2009.05.25/
>>>> (Please ignore first suspend failure (3681.078646 - 3685.514358) - I forgot
>>>> to restore swap)
>>> Thanks.
>>>
>>> Can you please test the patch sent by Sebastian Ott in this thread?
>> BUG disappeared with this patch.
> 
> Thanks for testing.
> 
>> Is this a final fix?
> 
> I'm not sure yet.


This bug (first) is still with us as of 2.6.31-rc2-faf80d62e44dc627efb741f48db50c1858d1667c

Marcin
