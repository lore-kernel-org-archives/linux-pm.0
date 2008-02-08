From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c,
	could fix few machines
Date: Fri, 08 Feb 2008 13:02:57 -0800
Message-ID: <47ACC381.9070601@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <47AB975C.1010902@zytor.com>
	<20080208070419.GA4544@ucw.cz> <200802081723.16354.rjw@sisk.pl>
	<20080208210004.GA12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080208210004.GA12923@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Fri 2008-02-08 17:23:15, Rafael J. Wysocki wrote:
>> On Friday, 8 of February 2008, Pavel Machek wrote:
>>> Hi!
>> Hi,
>>
>>>>> I really need the entry point to be at offset 0, so 
>>>>> that I can get
>>>>> pointers to my data. I could not figure out how to do 
>>>>> it any other
>>>>> way. And if 0 is taken, I thought I'd put header at the 
>>>>> end.
>>>>>
>>>> Why not just put the structure at 0, and put pointers in 
>>>> the structure to everything else you need?
>>> segments:offsets rear its ugly head here. I need %ds to point to my
>>> data, and the way to do it is copy it from %cs; that needs start to be
>>> at 0.
>> Hm, why exactly is that necessay?
> 
> It is not _neccessary_. Try to come up with another method that gets
> relocations right. I could not :-(.
> 
> (Actually, putting table at the offset 0 and short jump at beggining
> of the table would probably do the trick. But that still keeps code at
> offset 0 :-).
> 									Pavel

Why not just put a pointer to the start of the code in the table, and 
make an indirect call to it?

Where is this code?

	-hpa
