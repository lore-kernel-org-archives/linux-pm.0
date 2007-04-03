From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Tue, 03 Apr 2007 09:37:45 +0200
Message-ID: <46120449.7070302@gmail.com>
References: <460B6E4B.3060004@gmail.com> <200704012123.54797.rjw@sisk.pl>
	<4610BDD7.5070201@gmail.com> <200704022318.28451.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704022318.28451.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki napsal(a):
> On Monday, 2 April 2007 10:24, Jiri Slaby wrote:
>> Rafael J. Wysocki napsal(a):
>>>>> On Thursday, 29 March 2007 09:44, Jiri Slaby wrote:
>>>>>> swsusp: critical section:
>>>>>> swsusp: Need to copy 131380 pages
>>>>>> swsusp: Not enough free memory
>>>>>> Error -12 suspending
>>>>>> Enabling non-boot CPUs ...
>>> As a workaround, you can try to change the initial image size so that i=
t's
>>> smaller than a half of the RAM size.  If that works, I'd like to send y=
ou a
>>> debug patch, if you don't mind. :-)
>> Yes, post it.
> =

> Appended.  Please send me the dmesg output from after a failing suspend
> (or in case it doesn't fail, from after the first one).

It doesn't fail, here is the output:

Shrinking memory...  Normal pages needed: 135122
Highmem pages needed: 0
Normal pages needed: 132256
Highmem pages needed: 0
Normal pages needed: 8271
Highmem pages needed: 0
Pages needed (total): 8271
Normal pages needed: 119657
Highmem pages needed: 0
Normal pages needed: 116791
Highmem pages needed: 0
Normal pages needed: 18446744073709528969
Highmem pages needed: 0
Pages needed (total): 18446744073709528969

Heh :), tmp is signed, this is -22647, I guess.

done (15505 pages freed)
Freed 62020 kbytes in 0.16 seconds (387.62 MB/s)

Complete dmesg may be obtained here:
http://www.fi.muni.cz/~xslaby/sklad/dmesg.swsusp

regards,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
