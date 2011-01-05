From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend hangs at platform phase [was: mmotm
 2010-12-23-16-58 uploaded]
Date: Wed, 05 Jan 2011 23:46:01 +0100
Message-ID: <4D24F4A9.8010301__15631.0598053553$1294267724$gmane$org@gmail.com>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org>
	<201101042357.08600.rjw@sisk.pl> <4D24E444.6080308@gmail.com>
	<201101052339.46453.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101052339.46453.rjw@sisk.pl>
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
Cc: "Brown, Len" <len.brown@intel.com>, mm-commits@vger.kernel.org, steiner@sgi.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 01/05/2011 11:39 PM, Rafael J. Wysocki wrote:
> On Wednesday, January 05, 2011, Jiri Slaby wrote:
>> On 01/04/2011 11:57 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, January 04, 2011, Jiri Slaby wrote:
>>>> On 01/04/2011 02:40 PM, Jiri Slaby wrote:
>>>>> On 12/24/2010 01:58 AM, akpm@linux-foundation.org wrote:
>>>>>> The mm-of-the-moment snapshot 2010-12-23-16-58 has been uploaded to
>>>>>
>>>>> Hi, this kernel regresses with respect to suspend to ram in comparison
>>>>> with mmotm 2010-12-16-14-56.
>>>>>
>>>>> This is OK:
>>>>> echo devices > /sys/power/pm_test
>>>>> pm-suspend
>>>>> This hangs at suspend phase:
>>>>> echo platform > /sys/power/pm_test
>>>>> pm-suspend
>>>
>>> Hmm.  So it looks like _PTS hangs?
>>
>> No _PST here :).
> 
> I really meant _PTS and yes, there is one and it does quite a lot of
> interesting stuff.

Yeah, I grepped for _PTS, but in a wrong file. My bad.

> Are you able to collect serial console (or equivalent) logs from that machine?

Unfortunately I don't have a second machine with serial port. What
exactly you want to dig out of the logs? Will netconsole work at that phase?

regards,
-- 
js
