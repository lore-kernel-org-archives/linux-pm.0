From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Wed, 11 Apr 2007 17:02:20 +0200
Message-ID: <461CF87C.4060801@gmail.com>
References: <460B6E4B.3060004@gmail.com> <200704111155.52455.rjw@sisk.pl>
	<461CBC3A.5090607@gmail.com> <200704111640.47171.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704111640.47171.rjw@sisk.pl>
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
> On Wednesday, 11 April 2007 12:45, Jiri Slaby wrote:
>> Rafael J. Wysocki napsal(a):
>>> On Wednesday, 11 April 2007 09:36, Jiri Slaby wrote:
>>>> Rafael J. Wysocki napsal(a):
>>>>> On Monday, 9 April 2007 22:07, Jiri Slaby wrote:
>>>>>> I have bad news for you :(. I thought I had unpatched kernel, but it=
 happens
>>>>>> in -rc6 too.
>>>>> I guess you mean you're still seeing the 'not enough memory to suspen=
d'
>>>>> problem?
>>>> Yes:
>>>> Disabling non-boot CPUs ...
>>>> kvm: disabling virtualization on CPU1
>>>> Breaking affinity for irq 9
>>>> CPU 1 is now offline
>>>> SMP alternatives: switching to UP code
>>>> CPU1 is down
>>>> swsusp: critical section:
>>>> swsusp: Need to copy 158309 pages
>>>> swsusp: Not enough free memory
>>>> Error -12 suspending
>>>> Enabling non-boot CPUs ...
>>>> SMP alternatives: switching to SMP code
>>>> Booting processor 1/2 APIC 0x1
>>>> Initializing CPU#1
>>> How reproducible is it?  I'm going to try to reproduce it on one of my =
boxes.
>> My tip is one of three cases: after some work on fresh boot -- some
>> consumers such as thunderbird, firefox, 10 or so terminals with
>> gnome-session. Single xterm + gnome-session semms not to be a problem.
> =

> Does the workaround with setting the image size below 1/2 of RAM work for=
 you?

Yes. Yesterday I must set the value to 350M -- 400M was not enough.

regards,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
