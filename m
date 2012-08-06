From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Mon, 6 Aug 2012 12:28:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208061226460.1649-100000@iolanthe.rowland.org>
References: <501FEA29.1030400@pavlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <501FEA29.1030400@pavlinux.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Vasilyev <pavel@pavlinux.ru>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Aug 2012, Pavel Vasilyev wrote:

> 06.08.2012 18:36, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 6 Aug 2012, Pavel Machek wrote:
> >
> >> On Thu 2012-07-26 21:39:38, Len Brown wrote:
> >>> ...both give the number of chars in the string
> >>> without the '\0', as strncmp() wants,
> >>> but sizeof() is compile-time.
> >>
> >> What about introducing something like streq() to do this
> >> automatically? This is ugly....
> >>
> >> #define streq(a, b) ... if (_buildin_constant(b)) ...
> >>
> >> ?
> >>
> >>> -	if (!strncmp(val, "enable", strlen("enable"))) {
> >>> +	if (!strncmp(val, "enable", sizeof("enable") - 1)) {
> >
> > While you're at it, there's no point using strncmp when you know the
> > length of one of the strings beforehand.  Just use memcmp, and don't
> > subtract 1 from the sizeof value.
>=20
> http://www.gossamer-threads.com/lists/engine?do=3Dpost_attachment;posta=
tt_id=3D41157;list=3Dlinux

Interestingly, many (all?) of the changes in that patch are wrong=20
because they don't try to match the terminating '\0'.  As a result,=20
they will match against extensions of the target string as well as the=20
target string itself.

Alan Stern
