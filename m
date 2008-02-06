From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Wed, 06 Feb 2008 23:40:35 +0100
Message-ID: <47AA3763.7000106__6358.11931356347$1202337751$gmane$org@free.fr>
References: <47A5C399.7010405@free.fr> <47A6B758.7070405@free.fr>
	<47A8EB02.90502@free.fr> <200802060020.12289.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802060020.12289.rjw@sisk.pl>
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
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 6 of February 2008, matthieu castet wrote:
>> Hi,
>>
>> matthieu castet wrote:
>>> matthieu castet wrote:
>>>> Pavel Machek wrote:
>>>>> Hmm, maybe I know where problem could be. Try
>>>>>
>>>>>         movl     $(wakeup_stack - wakeup_code), %esp              # 
>>>>> Private stack is needed for ASUS bo\
>>>>>
>>>>> instead of existing stack setup. That helped on one of my test-boxes
>>>> Thanks, I will try that.
>>>> Because clearing the flags imply pop/push in the stack it could be the 
>>>> problem
>>> That doesn't help : it still crash in pushl $0.
>>>
>> All stack stuff in wakeup_code crash for me.
>> I tried to change the stack position, make sure upper bit of %esp are 
>> clear, ... nothing work.
>> What's are strange is that according to my x86 manual, in real mode the 
>> failure can only happen if the stack wrap which is not the case here.
>> Any x86 guru advice ?
>>
>> If I remove stack access (remove clearing flag stuff, not call to video 
>> stuff) the resume works.
> 
> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
> see if that breaks?
Yes that also break.

Matthieu
