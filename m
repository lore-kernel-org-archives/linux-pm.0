From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Wed, 18 Apr 2007 14:11:44 -0400
Message-ID: <46265F60.4040600@tmr.com>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl> <46254666.2020308@tmr.com>
	<Pine.LNX.4.64.0704172045100.18821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0704172045100.18821@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Robert P. J. Day wrote:
> On Tue, 17 Apr 2007, Bill Davidsen wrote:
>
>   =

>> Rafael J. Wysocki wrote:
>>     =

>>> [appropriate CCs added]
>>>
>>> On Friday, 13 April 2007 02:33, Robert P. J. Day wrote:
>>>       =

>>>> just something i threw together, not in final form, but it represents
>>>> tossing the legacy PM stuff.  at the moment, the menuconfig entry for
>>>> PM_LEGACY lists it as "DEPRECATED", while the help screen calls it
>>>> "obsolete."  that's a good sign that it's getting close to the time
>>>> for it to go, and the removal is fairly straightforward, but there's
>>>> no mention of its removal in the feature removal schedule file.
>>>>         =

>>> It's been like this for a long long time.  I think you're right that it=
 can
>>> be
>>> dropped, but I don't know the details (eg. why it hasn't been dropped y=
et).
>>>
>>>       =

>> One reason was that there are (were?) a number of machines which only po=
wered
>> down properly using apm. It was discussed as part of shutting down after=
 power
>> failure when your UPS is running out of power.
>>     =

>
> um ... what does APM have to do with legacy PM?  two different issues,
> no?
>   =

Since the patches are going into apm.c and apm was used for suspend and =

poweroff before ACPI was a feature of the hardware, I assume there's a =

relationship. As of 2.6.9 ACPI still couldn't power down one of my old =

boxes, it hasn't been updated since that time, so I can't say what later =

kernels will do.

-- =

bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979
