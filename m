From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [BUG] ThinkPad T520 overheating with P-State driver
Date: Thu, 7 May 2015 07:47:26 -0700
Message-ID: <000d01d088d4$bd1fb340$375f19c0$@net>
References: <2208008.uDRZL3Gdb7@merkaba> <000601d08870$b2979e60$17c6db20$@net> <7417602.R7WtsaR5vb@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7417602.R7WtsaR5vb@merkaba>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Martin Steigerwald' <martin@lichtvoll.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 'Kristen Carlson Accardi' <kristen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 2015.05.07 01:20 Martin Steigerwald wrote:
> Am Mittwoch, 6. Mai 2015, 19:51:19 schrieb Doug Smythies:
>> On 2015.05.06 13:37 Martin Steigerwald wrote:

Martin,

It would be best to continue with specifics of your actual
potential bug, in your bug report [1]. I'll reply
to some of your questions there.

>>> There is also some other bug report about this:
>>> Please change intel_pstate default to disable
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647
>>> appears to be quite old, but still seems unresolved.
>>=20
>> That bug report is very old, and is closed.
>> I made a late entry on that bug report on 2014.06.08,
>> and have submitted a patch set to deal with, among other things,
>> the long duration issue.

> Oh, I thought it was just closed by disabling Intel P-State, I didn=B4=
t see=20
> any actual fix to the issue in there. Ah, okay, your last comment men=
tioned=20
> fixed, I was not sure whether they really fixed the issue from readin=
g your=20
> comment.

The follow up bug report is this one:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1333322
"enable intel_pstate as default with thermald for x86"

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D97261
