From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Sun, 9 Nov 2008 21:17:38 -0800
Message-ID: <dd18b0c30811092117mc7bd310kaac33f5b1ff0a61d__14072.4280303859$1226332892$gmane$org@mail.gmail.com>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
	<20081108075008.GA8177@ime.usp.br>
	<dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
	<20081109024514.GA11744@ime.usp.br> <20081109113332.GD6094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109113332.GD6094@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: yakui.zhao@intel.com, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 9, 2008 at 3:33 AM, Pavel Machek <pavel@suse.cz> wrote:
> On Sun 2008-11-09 00:45:14, Rog=E9rio Brito wrote:
>> Hi, Justin and others.
>>
>> On Nov 08 2008, Justin Mattock wrote:
>> > On Fri, Nov 7, 2008 at 11:50 PM, Rog=E9rio Brito <rbrito@ime.usp.br> w=
rote:
>> > > I think that I have some more information regarding the suspend/hibe=
rnate
>> > > issue: with Ubuntu's 2.6.27 kernel, I can't hibernate my laptop, but=
 with
>> > > vanilla 2.6.28-rc3, I can hibernate (I have not tested it much, but =
it
>> > > seems to work).
>>
>> Just some extra information here: while I can hibernate with vanilla
>> 2.6.28-rc3, upon resuming, it takes *minutes* (I don't know how many
>> minutes, but probably something like 5 minutes or so!) for the desktop to
>> have any effect (despite the fact that I can move the mouse without any
>> problems).
>
> Try it from the text console, and see what exactly stops
> responding. "killall klogd" is your friend.
>                                                                Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
>

FWIW, running radeon and s2ram
gives me a successful wakeup,
no delays only bluetooth-applet fails
to show back up as eye candy.

-- =

Justin P. Mattock
