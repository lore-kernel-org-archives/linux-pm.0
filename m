From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Tue, 7 Aug 2012 13:24:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208071322070.2400-100000@iolanthe.rowland.org>
References: <50206A3A.8020706@pavlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <50206A3A.8020706@pavlinux.ru>
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

On Tue, 7 Aug 2012, Pavel Vasilyev wrote:

> 06.08.2012 23:59, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 6 Aug 2012, Pavel Vasilyev wrote:
> >
> >>>> http://www.gossamer-threads.com/lists/engine?do=3Dpost_attachment;=
postatt_id=3D41157;list=3Dlinux
> >>>
> >>> Interestingly, many (all?) of the changes in that patch are wrong
> >>> because they don't try to match the terminating '\0'.  As a result,
> >>> they will match against extensions of the target string as well as =
the
> >>> target string itself.
> >>>
> >>
> >> strNcmp compare N bytes - http://lxr.linux.no/#linux+v3.5/lib/string=
.c#L270
> >> memcmp compare N bytes  - http://lxr.linux.no/#linux+v3.5/lib/string=
.c#L651
> >
> > Yes.  So if s contains "abcde" then
> >
> > 	memcmp(s, "abc", 3) and strncmp(s, "abc", 3) will both return 0, and
> > 	memcmp(s, "abc", 4) and strncmp(s, "abc", 4) will both return 1.
>=20
> No matter what is contained in *s, "abcde" or "abcxxx",
> are important first N bytes. The second example, you see,
> a little bit stupid, and devoid of logic. :)

Maybe yes, maybe no.  It all depends on what you want.

For example, if you're looking for "on" or "off", what should you do
when the user writes "onoff"?  You could accept it as meaning the same
as "on", but if you were being careful then you would want to reject it
as a meaningless value.

Alan Stern
