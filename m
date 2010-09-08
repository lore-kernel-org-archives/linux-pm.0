From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Fan runs full speed after S3 sometimes (regression)
Date: Wed, 08 Sep 2010 15:27:00 +0200
Message-ID: <4C878F24.9010004__398.035653825168$1283952512$gmane$org@gmail.com>
References: <4C613619.30309@gmail.com> <4C619CF0.30609@gmail.com>
	<20100820063107.GB1607@ucw.cz> <4C6E233A.5000209@gmail.com>
	<20100821170551.GA27159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100821170551.GA27159@elf.ucw.cz>
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
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On 08/21/2010 07:05 PM, Pavel Machek wrote:
>>>>> I don't know how to debug that. Bisection is out of question -- it
>>>>> happens once in 10 or 20 cases. There are no fan entries in /sys.
>>>
>>> Well, doing 20 suspends in a row from a script should not be too bad.
>>
>> 20 is just a guess. I haven't seen it for pretty few days until the day
>> before yesterday. And it looks like CPU1 is brought up a half way. When
>> the fan was at full speed I tried:
>> echo 0 > /sys/devices/system/cpu/cpu1/online
>> and whole system freezed. Otherwise this commands succeeds.
> 
> Ok, so this looks like the kernel problem, on the other hand. Two
> different problems?

Actually, I haven't seen it after an upgrade to the next -mm kernel.
Consider it as closed as WORKSFORME for now.

thanks anyway,
-- 
js
