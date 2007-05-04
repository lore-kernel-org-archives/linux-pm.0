From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation and suspend patchset
Date: Fri, 4 May 2007 14:02:40 +0200
Message-ID: <200705041402.40964.rjw@sisk.pl>
References: <200705011558.11170.rjw@sisk.pl>
	<1178219335.4575.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178219335.4575.4.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 3 May 2007 21:08, Johannes Berg wrote:
> Hi Rafael,
>=20
> Some bugs with freezer_exempt:
>=20
> kernel/softirq.c: In function =E2=80=98ksoftirqd=E2=80=99:
> kernel/softirq.c:515: warning: implicit declaration of function =E2=80=98=
freezer_exempt=E2=80=99
> [...]
>=20
> Maybe some header file they all use pulls in freezer.h on x86 but not o=
n
> powerpc? This fixes it.

These #includes are added by

008-add-try_to_freeze-everywhere.patch

Perhaps it's one of the patches that don't apply to the current -git?

Rafael
