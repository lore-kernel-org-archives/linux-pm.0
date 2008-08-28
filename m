From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: FW:  select with timeout across S3
Date: Thu, 28 Aug 2008 13:32:47 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C09639B7A__4083.45702239803$1219945242$gmane$org@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C90934.1740FDE4"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C90934.1740FDE4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The behavior of linux (in both 2.4.x and 2.6.x) is when the processor
sleeps, timeouts on select don't take into account the sleep time,
only the run time.

For example, this program should pause for 10 minutes -- however
if we go into S3 in the middle its pausing for (10 minutes + time in
S3)

I saw this on both 2.6.20 and 2.6.22...

marty

-----Original Message-----
From: linux-pm-bounces@lists.linux-foundation.org
[mailto:linux-pm-bounces@lists.linux-foundation.org] On Behalf Of Pavel
Machek
Sent: Thursday, August 28, 2008 10:30 AM
To: Leisner, Martin
Cc: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] select with timeout across S3

On Wed 2008-08-27 15:23:13, Leisner, Martin wrote:
> What's a good way to "wait" across a transition to/from processor
sleep
> (acpi S3 or other means)?
>=20
>=20
> It seems the timeouts on select(2) only deal with with time correctly
> when the processor is awake -- when the processor is sleeping its not
> subtracted from the request...
>=20
> The desirable behavior out of select would be for it to timeout
whenever
> the system wakes up if the desired interval has elapsed...

That sounds like a bug. Can you write small demo program and post it
to lkml?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures)
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
_______________________________________________
linux-pm mailing list
linux-pm@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/linux-pm

------_=_NextPart_001_01C90934.1740FDE4
Content-Type: application/octet-stream;
	name="select.c"
Content-Transfer-Encoding: base64
Content-Description: select.c
Content-Disposition: attachment;
	filename="select.c"

I2luY2x1ZGUgPHN5cy9zZWxlY3QuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CgptYWluKCkKewoJc3Ry
dWN0IHRpbWV2YWwgdDsKCWludCByZXQ7CgoJdC50dl9zZWMgPSA2MCAqIDEwOwoJdC50dl91c2Vj
ID0gMDsKCglyZXQgPSBzZWxlY3QoMCwgTlVMTCwgTlVMTCwgTlVMTCwgJnQpOwoJcHJpbnRmKCJy
ZXQgPSAlZFxuIiwgcmV0KTsKfQoKCQo=

------_=_NextPart_001_01C90934.1740FDE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C90934.1740FDE4--
