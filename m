From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Tue, 17 Apr 2007 18:12:54 -0400
Message-ID: <46254666.2020308@tmr.com>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704131022.45315.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, "Robert P. J. Day" <rpjday@mindspring.com>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> [appropriate CCs added]
> =

> On Friday, 13 April 2007 02:33, Robert P. J. Day wrote:
>> just something i threw together, not in final form, but it represents
>> tossing the legacy PM stuff.  at the moment, the menuconfig entry for
>> PM_LEGACY lists it as "DEPRECATED", while the help screen calls it
>> "obsolete."  that's a good sign that it's getting close to the time
>> for it to go, and the removal is fairly straightforward, but there's
>> no mention of its removal in the feature removal schedule file.
> =

> It's been like this for a long long time.  I think you're right that it c=
an be
> dropped, but I don't know the details (eg. why it hasn't been dropped yet=
).
>  =

One reason was that there are (were?) a number of machines which only =

powered down properly using apm. It was discussed as part of shutting =

down after power failure when your UPS is running out of power.

I haven't checked on that in a while, I'm just supplying one reason =

since you wondered.

-- =

Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
