From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc4-mm1
Date: Tue, 20 Mar 2007 21:13:52 +0100
Message-ID: <46004080.6080202@gmail.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<45FFF026.4030502@gmail.com>
	<20070320080944.9cb3c765.akpm@linux-foundation.org>
	<20070320183821.GD2670@elf.ucw.cz> <4600389E.6030901@gmail.com>
	<20070320195659.GA3545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320195659.GA3545@elf.ucw.cz>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek napsal(a):
> Hi!
> =

>>>> Also, it might be useful to add a temporary /proc/freeze-unfreeze thing
>>>> which will simply do a freeze/unfreeze cycle.  Then we can apply vario=
us
>>>> workloads to the machine while madly stressing the freezer code.  =

>>> echo testproc > /sys/power/disk; echo disk > /sys/power/state ... is
>>> pretty much what you want.
>> Ok, I'll try this.
> =

> It will not help you -- probably -- it is equivalent to just running
> s2ram. But it should make "successful" testing easier, because you no
> longer need machine with working suspend to test refrigerator.

Aha, I didn't read it carefully. Suspend is working, but not in this kernel.
I haven't tried s2ram in this version. Should I (I'm away from it) -- would
it show something?

regards,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
