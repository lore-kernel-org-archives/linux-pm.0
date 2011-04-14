From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Thu, 14 Apr 2011 10:04:47 +0800
Message-ID: <BANLkTim5RW8g=N=4RSQ2ZuSJ1dS_wuEw3w@mail.gmail.com>
References: <BANLkTik8bWF8c+BmrzzqOZiWWwujskgs7w@mail.gmail.com>
	<Pine.LNX.4.44L0.1104121200530.2000-100000@iolanthe.rowland.org>
	<20110412162324.GA25315@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110412162324.GA25315@elf.ucw.cz>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

2011/4/13 Pavel Machek <pavel@ucw.cz>:
> Hi!
>
>> > If you want to figure out which device suspend too slow, this patch
>> > will do better.
>>
>> It's okay with me. =A0Presenting the information in an easy-to-read form
>> is fine. =A0I just wanted to point out that the information is already
>> available.
>>
>> BTW, there are several spelling errors in the Kconfig help text in your
>> patch. =A0You should fix them before submitting the patch again.
>
> Well well. I'd avoid placing this in kernel. It seems that parsing
> dmesg to get the "better" debugging information out is pretty much
> trivial.

I'm admit it's not a big feather, but it's belong to PM_DEBUG, it's a
debug feather.
It's very useful in embedded Linux development. Also, when someone
debugging suspend/resume in these system, they always have to
implement a version like this. So I think add this debug feather to
kernel can do some help.

I'm ok with drop this patch, I just want to clarify the aim of patch.

Thanks.

Jiejing

>
> Just publish that shell script somewhere...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
>
