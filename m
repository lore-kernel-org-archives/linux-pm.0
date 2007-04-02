From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Mon, 02 Apr 2007 10:24:55 +0200
Message-ID: <4610BDD7.5070201@gmail.com>
References: <460B6E4B.3060004@gmail.com> <200703291639.41515.rjw@sisk.pl> <460FF726.7090601@gmail.com> <200704012123.54797.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752940AbXDBIZJ@vger.kernel.org>
In-Reply-To: <200704012123.54797.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-pm@lists.osdl.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki napsal(a):
>>> On Thursday, 29 March 2007 09:44, Jiri Slaby wrote:
>>>> swsusp: critical section:
>>>> swsusp: Need to copy 131380 pages
>>>> swsusp: Not enough free memory
>>>> Error -12 suspending
>>>> Enabling non-boot CPUs ...

> As a workaround, you can try to change the initial image size so that it's
> smaller than a half of the RAM size.  If that works, I'd like to send you a
> debug patch, if you don't mind. :-)

Yes, post it.

# cat /sys/power/image_size
524288000
# echo disk >/sys/power/state
error
# echo disk >/sys/power/state
error
# echo $((400*1024*1024)) > /sys/power/image_size
# echo disk >/sys/power/state
ok
# dmesg|grep Memory:
Memory: 1027160k/1048256k available (2559k kernel code, 20348k reserved,
1114k data, 188k init)

I don't undestand it too much, but can't be shared video memory involved
somehow?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
