From: Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Linux 3.0-rc4 intermittent failure to resume
Date: Thu, 30 Jun 2011 08:21:44 +0800
Message-ID: <4E0BC198.4040305@fnarfbargle.com>
References: <4E0286F3.6030003@wasp.net.au> <4E093ECD.7040600@fnarfbargle.com>
	<4E0B2737.2010505@fnarfbargle.com> <201106292134.34485.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106292134.34485.rjw@sisk.pl>
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

On 30/06/11 03:34, Rafael J. Wysocki wrote:
> On Wednesday, June 29, 2011, Brad Campbell wrote:

>> On the occasions it failed to resume (which were many) it turns out
>> /bin/resume was being called prior to udev having created /dev/snapshot.
>>
>> I put a simple wait loop in the resume script to wait for the creation
>> of /dev/snapshot and I've not had a fail to resume since.
>>
>> Curse you asynchronous dynamic device creation<shakes fist>
>
> Thank you very  much for nailing this down, I was afraid there were some
> obscure bug lurking in the kernel code.

Yeah, no worries.

I set up a loop to do automated suspend/resume cycles.
I managed over 100 cycles while compiling 2 kernels in the background.

Over the 100 cycles the kernel locked up twice, but both times were in 
very early boot. I power cycled the machine and it resumed with no 
problems, so the issue is not with the suspend/resume code.
