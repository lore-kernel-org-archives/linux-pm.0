From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.22-rc3-mm1
Date: Thu, 31 May 2007 17:29:54 +0200
Message-ID: <465EE9F2.8080905__997.922980650578$1180625461$gmane$org@googlemail.com>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070530235823.793f00d9.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

Andrew Morton napisa=C5=82(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.22-rc=
3/2.6.22-rc3-mm1/
>=20

FYI suspend to disk doesn't work anymore on my box, system hangs after "S=
uspending console(s)" message.

[  186.297753] Shrinking memory...  =08-=08\=08|=08/=08-=08\=08|=08done (=
113064 pages freed)
[  187.841914] Freed 452256 kbytes in 1.54 seconds (293.67 MB/s)
[  187.847730] Suspending console(s)

http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3-mm1/c=
onsole.log
http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.22-rc3-mm1/m=
m-config

Regards,
Michal


--=20
"Najbardziej brakowa=C5=82o mi twojego milczenia."
-- Andrzej Sapkowski "Co=C5=9B wi=C4=99cej"
