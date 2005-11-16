From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 08:10:19 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25371260996765788=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25371260996765788==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

I worry that this is just adding more thrash to a historically unstable
implementation.  How long do we users have to wait for a swsusp
implementation where we don't have to worry about breaking from one
kernel release to the next?

I agree with this post http://lkml.org/lkml/2005/9/15/125 and note that
making too large of a change thrashes the users a lot and if it doesn't
solve a real problem or enable something critical, why make the changes?


--mgross

>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org]
>On Behalf Of Pavel Machek
>Sent: Wednesday, November 16, 2005 12:56 AM
>To: Dave Jones; kernel list; Rafael J. Wysocki; Linux-pm mailing list
>Subject: Re: [linux-pm] [RFC] userland swsusp
>
>Hi!
>
>>  > > Even it were not for this, the whole idea seems misconcieved to
me
>>  > > anyway.
>>  >
>>  > ...but how do you provide nice, graphical progress bar for swsusp
>>  > without this? People want that, and "esc to abort", compression,
>>  > encryption. Too much to be done in kernel space, IMNSHO.
>>
>> I'll take "rootkit doesnt work" over "bells and whistles".
>
>It moves bunch of code from kernelspace to userspace. You don't have
>to add bells and whistles at the same time. That's normally called
>good thing. If Fedora has special needs, fine.
>								Pavel
>--
>Thanks, Sharp!


--===============25371260996765788==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25371260996765788==--
