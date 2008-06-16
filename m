From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Double suspend to ram doesn't work on acer aspire
 5720g
Date: Mon, 16 Jun 2008 08:45:32 +0300
Message-ID: <4855FDFC.9010701@gmail.com>
References: <48554056.6070902@gmail.com> <200806151928.16993.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806151928.16993.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday, 15 of June 2008, Maxim Levitsky wrote:
>> Hi,
> 
> Hi,
> 
>> If I suspend system to ram twice, the system hangs on resume.
>>
>> Otherwise system suspends fine.
>>
>> I can do the following:
>>
>> suspend to disk
>> suspend to disk
>> suspend to ram
>> suspend to disk
>> suspend to ram
>> suspend to disk
>> suspend to disk.
>>
>> but not this:
>>
>> suspend to ram
>> suspend to ram.
>> <-> hang
>>
>>
>> Before I start digging deeper, are there patches floating around that 
>> could fix this issue?
>>
>> (I use latest linus -git kernel)
>>
>> (I tried to use minimal system and got same results)
>>
>> Have to confess that I use nvidia binary drivers, and without them
>> video doesn't resume, but I did test this issue without them, and
>> got same results.
>>
>> (after first suspend to ram video didn't resume, but I was able to 
>> control the system with keyboard, and I then put it to sleep again, and 
>> on resume, system didn't respond.)
> 
> Hard to say what the problem is.  If it's a regression (ie. you have a kernel
> that works 100% of the time) and is readily reproducible, bisection may help
> find the patch that broke it.
> 
> Thanks,
> Rafael

Sadly it isn't a regression (I bought this laptop just few weeks ago)
I can try older kernels, I just asked whenever there are some known 
bugfixes for me to try.

I will dig this bug out,

Best regards,
	Maxim Levitsky
