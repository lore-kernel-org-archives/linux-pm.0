From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/7] pm: improve error code of
	pm_notifier_call_chain()
Date: Sat, 9 Jul 2011 00:50:48 +0900
Message-ID: <CAC5umyhZ35AXtwA=Uy1+zp9N=NwLths=h6jKUK53f0U+tZMZZA__34682.3610867888$1310140399$gmane$org@mail.gmail.com>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<20110703171539.GF21127@elf.ucw.cz>
	<CAC5umyibWo===0Lr5Wz2moOvnf0qiAvFLo4--sLCRmx4sJrdRA@mail.gmail.com>
	<201107072306.02708.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107072306.02708.rjw@sisk.pl>
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
Cc: linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2011/7/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday, July 04, 2011, Akinobu Mita wrote:
>> 2011/7/4 Pavel Machek <pavel@ucw.cz>:
>> > On Sun 2011-07-03 23:16:15, Akinobu Mita wrote:
>> >> This enables pm_notifier_call_chain() to get the actual error code
>> >> in the callback rather than always assume -EINVAL by converting all
>> >> PM notifier calls to return encapsulate error code with
>> >> notifier_from_errno().
>> >>
>> >> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> >> Cc: Pavel Machek <pavel@ucw.cz>
>> >
>> > Nothing obviously wrong here.
>>
>> Thanks. Can I add your ACK for this patch?
>
> Do you want me to take this patch?

Yes, please merge it to your tree.
