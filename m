From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.22-rc1 regression: tifm prevents suspending
	[was: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR]
Date: Sat, 19 May 2007 22:50:14 +0200
Message-ID: <6bffcb0e0705191350l71d9ebeeo7e0f90582355af5f__41536.7242684171$1179607895$gmane$org@mail.gmail.com>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070519151110.GA3393@inferi.kami.home>
	<6bffcb0e0705191017n1d1e6eb7k1370d5ce5cf17fb9@mail.gmail.com>
	<200705192029.37436.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705192029.37436.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Alex Dubov <oakad@yahoo.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mattia Dongili <malattia@linux.it>, Pierre Ossman <drzeus@drzeus.cx>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 19/05/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, 19 May 2007 19:17, Michal Piotrowski wrote:
[..]
> > Subject    : Broken suspend on SMP with tifm
> > References : http://lkml.org/lkml/2007/5/13/161
> > Submitter  : Rafael J. Wysocki <rjw@sisk.pl>
> > Status     : patch was suggested
> >
> > Actually should be "a few patches was suggested"
> >
> > Rafael, please point me the right patch.
>
> Fixed in the mainline, by
>
> commit e3dfd2964ea86ae65f511b10d62ea54d46db3708
> make freezeable workqueues singlethread

Thanks for the information.

>
> Greetings,
> Rafael
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
