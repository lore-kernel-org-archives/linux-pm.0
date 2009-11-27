From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: Weird suspend/resume problem on HP nx6325 w/
	openSUSE 11.2 w/ -rc8
Date: Fri, 27 Nov 2009 12:02:37 -0800
Message-ID: <dd18b0c30911271202m4487eb29jf7fa9fac7e3873bd__45804.7171742239$1259352757$gmane$org@mail.gmail.com>
References: <200911220015.30912.rjw@sisk.pl>
	<21d7e9970911211955i69c12969n3085b6fc2c4a95f9@mail.gmail.com>
	<200911270204.15100.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911270204.15100.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 26, 2009 at 5:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday 22 November 2009, Dave Airlie wrote:
>> On Sun, Nov 22, 2009 at 9:15 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > Hi,
>> >
>> > I'm not really sure where this should be reported, but here it goes.
>> >
>> > After installing openSUSE 11.2 on my testbed nx6325 I noticed that res=
ume
>> > (from suspend to RAM) stopped working on it. =A0Apparently, it hanged =
while
>> > switching from the console back to X and the box remained completely
>> > unresponsive after that (it didn't even react to the magic sysrq). =A0=
However,
>> > it used to work just fine with -rc7 and openSUSE 11.1, so I figured th=
e problem
>> > was related to the new X driver, which is radeon module version 6.12.4=
 (xorg
>> > server 1.6.5).
>> >
>> > So, I started to investigate and found that after a suspend from a fra=
mebuffer
>> > console, the resume had always worked. =A0However, when I switched fro=
m X to the
>> > framebuffer console, suspended, resumed and switched back to X, the bo=
x hanged
>> > immediately just like during resume after a suspend from under X. =A0[=
There also
>> > were some problems when switching from X to the framebuffer console an=
d back
>> > which seemd to be independent of suspend/resume (in short, the screen =
stays
>> > black after a switch from the framebuffer console to X and you need to=
 kill X
>> > to fix this).]
>>
>> You are using radeonfb on it? or vesafb?
>
> vesafb
>
>> first test is to try without either of those installed.
>
> That doesn't change the behavior AFAICS.
>
>> From memory though that machines an Xpress 200M
>
> Yes, it has this one.
>
>> which is the the worst graphics card for use with open drivers and has
>> always caused no-end of pain.
>
> Too bad. :-(
>
>> Its also mostly undocumented when it comes to errata and workarounds.
>
> Well, so I guess this is a hardware errata.
>
> Still, it worked with the older X, so I wonder if I can make the new X wo=
rk
> like the old one?
>
> Best,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

>From over here I was running the stable kernel
on a freshly built clfs system, with the latest xorg from git
suspend worked as is. Then loading the latest git kernel
noticed the lagging of the wake up. When I get a chance I'll
do a bisect and see If I come up with anything.


-- =

Justin P. Mattock
