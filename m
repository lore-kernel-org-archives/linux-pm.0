From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Sun, 01 Apr 2007 20:17:10 +0200
Message-ID: <460FF726.7090601@gmail.com>
References: <460B6E4B.3060004@gmail.com> <200703291639.41515.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703291639.41515.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki napsal(a):
> On Thursday, 29 March 2007 09:44, Jiri Slaby wrote:
>> Hi,
>>
>> I'm getting this while trying to swsups the machine in -rc5, -rc4 is fin=
e:
>>
>> Disabling non-boot CPUs
>> CPU 1 is now offline
>> SMP alternatives: switching to UP code
>> CPU1 is down
>> swsusp: critical section:
>> swsusp: Need to copy 131380 pages
>> swsusp: Not enough free memory
>> Error -12 suspending
>> Enabling non-boot CPUs ...
>>
>> # cat /sys/power/resume
>> 8:6
>> # cat /proc/swaps
>> Filename                                Type            Size    Used    =
Priority
>> /dev/sda6                               partition       1004020 0       =
-1
>>
>> Any other info needed?
> =

> Beats me.  There were no changes that could result in such a thing between
> -rc4 and -rc5, at least not in the swsusp department.
> =

> Could you please try to bisect?

Hm, there is some kind of magic.

First, I have fglrx, that taints kernel. If I use vesa drv with X, it
doesn't resume the card. If I try console, it doesn't resume it too.

fglrx + suspend.sf.net seems to work -- 3 unsuccesfull disk >
sys/power/state and after s2dsk with backspace during suspend, disk >
sys/power/state works. But this sceniario happened only once...

Next, it was so early to utter -rc4 is good, it happens there too, so it's
not a regression.

I have no idea what's wrong, is there any possibility to figure out, what
happens (esp. kick fglrx off)? Disable higmem? Try UP?

thanks,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
