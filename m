From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.22-rc7: known regressions v2
Date: Sat, 07 Jul 2007 18:06:44 +0200
Message-ID: <468FBA14.9040706__39388.0513533533$1183824467$gmane$org@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Ben. Herrenschmidt" <benh@kernel.crashing.org>, Ani Joshi <ajoshi@kernel.crashing.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrey Borzenkov <arvidjaar@mail.ru>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ioan Ionita <opslynx@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc7.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Hugh Dickins                           2
Andi Kleen                             2
Andrew Morton                          1
Benjamin Herrenschmidt                 1
Bj=F6rn Steinbrink                       1
Bjorn Helgaas                          1
Christoph Lameter                      1
David Woodhouse                        1
Jean Delvare                           1
Olaf Hering                            1
Siddha, Suresh B                       1
Trent Piepho                           1
Ville Syrj=E4l=E4                          1



FBDEV

Subject         : SLUB kmalloc-32768: Poison check failed@0xc1e20000 slab=
 0xc04de400
References      : http://lkml.org/lkml/2007/7/4/305
Last known good : ?
Submitter       : David Woodhouse <dwmw2@infradead.org>
Caused-By       : ?
Handled-By      : ?
Status          : unknown



FS

Subject    : 2.6.22-rc4-git5 reiserfs: null ptr deref.
References : http://lkml.org/lkml/2007/6/13/322
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
Status     : problem is being debugged



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Suspend

Subject         : reiserfs/libata sporadically hangs on resume from hiber=
nation
References      : http://lkml.org/lkml/2007/6/30/5
Last known good : ?
Submitter       : Andrey Borzenkov <arvidjaar@mail.ru>
Caused-By       : ?
Handled-By      : Rafael J. Wysocki <rjw@sisk.pl>
Status          : problem is being debugged



x86-64

Subject    : x86-64 2.6.22-rc2 random segfaults
References : http://lkml.org/lkml/2007/5/24/275
Submitter  : Ioan Ionita <opslynx@gmail.com>
Status     : Unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
