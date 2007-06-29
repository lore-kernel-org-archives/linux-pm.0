From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-rc6: known regressions v2
Date: Fri, 29 Jun 2007 17:13:21 +0200
Message-ID: <46852191.2080506__21426.9524477006$1183130133$gmane$org@googlemail.com>
References: <46852033.5020708@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46852033.5020708@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, Mikael Pettersson <mikpe@it.uu.se>, discuss@x86-64.org, linux@horizon.com, LKML <linux-kernel@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Ioan Ionita <opslynx@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc6.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Hugh Dickins                           2
Andi Kleen                             1
Bj=F6rn Steinbrink                       1
Bjorn Helgaas                          1
Jean Delvare                           1
Olaf Hering                            1
Siddha, Suresh B                       1
Trent Piepho                           1
Ville Syrj=E4l=E4                          1



Sparc64

Subject    : random invalid instruction occourances on sparc32 (sun4c)
References : http://lkml.org/lkml/2007/6/17/111
Submitter  : Mark Fortescue <mark@mtfhpc.demon.co.uk>
Status     : problem is being debugged

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Suspend

Subject    : Transmeta/APM regression - problems with resume
References : http://lkml.org/lkml/2007/6/27/168
Submitter  : linux@horizon.com
Status     : unknown



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
