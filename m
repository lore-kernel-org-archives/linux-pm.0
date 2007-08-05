From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/3] 2.6.23-rc2: known regressions
Date: Sun, 05 Aug 2007 21:48:12 +0200
Message-ID: <46B6297C.900__30418.804070405$1186415609$gmane$org@googlemail.com>
References: <46B5F74D.7010708@googlemail.com> <46B5FA32.50208@googlemail.com>
	<200708051858.12404.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708051858.12404.rjw@sisk.pl>
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
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki pisze:
> On Sunday, 5 August 2007 18:26, Michal Piotrowski wrote:
>> Hi all,
>>
>> Here is a list of some known regressions in 2.6.23-rc2.
>>
>> Feel free to add new regressions/remove fixed etc.
>> http://kernelnewbies.org/known_regressions
>>
>  
>> Power management
>>
>> Subject         : Kconfig: 'SUSPEND_SMP' refers to undefined symbol 'HOTPLUG_CPU'
>> References      : http://lkml.org/lkml/2007/8/4/39
>> Last known good : ?
>> Submitter       : Meelis Roos <mroos@linux.ee>
>> Caused-By       : ?
>> Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
>> Status          : unknown
> 
> Is being debugged.
> 
> Frankly, I don't know what to think about that.  With the Meelis' .config
> SUSPEND_SMP can't even be set ...

Meelis, have you used a "make randconfig" without "make oldconfig"?

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
