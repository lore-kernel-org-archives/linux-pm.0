From: david@lang.hm
Subject: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
 support on x86_64
Date: Sat, 25 Aug 2007 11:32:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708251132070.22470@asgard.lang.hm>
References: <200708241206.57178.rjw@sisk.pl> <200708241211.55319.rjw@sisk.pl>
	<20070824204632.GA5008@ucw.cz> <200708252027.26721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1005720952-1188066769=:22470"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708252027.26721.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1005720952-1188066769=:22470
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp2.linux-foundation.org id l7PIef49015588

On Sat, 25 Aug 2007, Rafael J. Wysocki wrote:

> On Friday, 24 August 2007 22:46, Pavel Machek wrote:
>> Hi!
>>
>>> From: Rafael J. Wysocki <rjw@sisk.pl>
>>>
>>> Make it possible to restore a hibernation image on x86_64 with the he=
lp of a
>>> kernel different from the one in the image.
>>>
>>> The idea is to split the core restoration code into two separate part=
s and to
>>> place each of them in a different page. =A0The first part belongs to =
the boot
>>
>> What happens in case where both parts want to be
>> at the same place? (Like kernel being restored is 4KB smaller, so that
>> routines now collide?)
>
> Bad things, but I can't see how to avoid that reliably.

can you at least detect it reliably? (feed a program both kernel images=20
and have it tell you 'yes/no')

David Lang
--680960-1005720952-1188066769=:22470
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1005720952-1188066769=:22470--
