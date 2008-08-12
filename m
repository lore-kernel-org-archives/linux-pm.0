From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: resume from s2ram regression (bisected to ftrace...)
Date: Tue, 12 Aug 2008 18:37:28 +0200
Message-ID: <20080812163724.GA5395__39943.3462335311$1218559472$gmane$org@joi>
References: <20080810170801.GA5739@joi> <200808101940.13753.rjw@sisk.pl>
	<20080810192444.GA5296@joi> <200808102148.03046.rjw@sisk.pl>
	<48A08475.1090805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <48A08475.1090805@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <srostedt@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 11, 2008 at 02:27:01PM -0400, Steven Rostedt wrote:
> Rafael J. Wysocki wrote:
>> On Sunday, 10 of August 2008, Marcin Slusarz wrote:
>>   
>>> On Sun, Aug 10, 2008 at 07:40:12PM +0200, Rafael J. Wysocki wrote:
>>>     
>>>> On Sunday, 10 of August 2008, Marcin Slusarz wrote:
>>>>       
>>>>> Hi
>>>>>
>>>>> Few days ago I discovered that resume from suspend to ram does not work 
>>>>> anymore
>>>>> on my 2.6.27-rc2 (actually 796aadeb1b2db9b5d463946766c5bbfd7717158c) 
>>>>> gentoo box.
>>>>> My computer just boots on resume. Today I had enough time to bisect it 
>>>>> and found
>>>>> (after 1 panic and 1 build breakage) out "the reason":
>>>>>
>>>>> $ git bisect good
>>>>> d05cdb25d80f06f77aa6bddb53cd1390d4d91a0b is first bad commit
>>>>> commit d05cdb25d80f06f77aa6bddb53cd1390d4d91a0b
>>>>> Author: Steven Rostedt <rostedt@goodmis.org>
>>>>> Date:   Mon May 12 21:20:54 2008 +0200
>>>>>
>>>>>     ftrace: fix dynamic ftrace selftest
>>>>>         
>>>> Does it still happen if:
>>>> - CONFIG_FTRACE is unset
>>>>       
>>> no
>>>
>>>     
>>>> - CONFIG_FTRACE is set, but CONFIG_FTRACE_STARTUP_TEST is unset?
>>>>       
>>> yes
>>>     
>>
>> Thanks for testing.
>>
>> Well, ftrace is a new feature in 2.6.27, IIRC, so this is not a regression 
>> in
>> the strict sense.
>>
>> Still, of couse, there is a bug in ftrace that needs to be fixed.  Steven?
>>   
> Sorry for the late response.
>
> Red Hat changed its mail servers, and my mail was in limbo for a while.
>
> I'm not doubting that FTRACE enabled breaks suspend to ram, but I find it 
> highly unlikely that the commit you posted was the culprit. Especially 
> since it still breaks when STARTUP_TEST is disabled. That change was a 
> STARTUP_TEST change only.  Perhaps it just moved things around enough to 
> cause your issues.
>
> But you say that if you take Linus's latest git tree, and revert only this 
> change, it works??

Yes.

> Hmm, this is very strange.

I agree. Any idea how to debug it?

Marcin
