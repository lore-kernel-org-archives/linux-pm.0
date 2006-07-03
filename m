From: Jiri Slaby <jirislaby@gmail.com>
Subject: swsusp regression
Date: Tue, 04 Jul 2006 00:44:52 +0159
Message-ID: <44A99DFB.50106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hello,

when suspending machine with hyperthreading, only Freezing cpus appears and=
 then
it loops somewhere. I tried to catch some more info by pressing sysrq-p. He=
re
are some captures:
http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif

It was working just perfect in 2.6.17-rcX-mmXs, but from 2.6.17-mmX times (=
maybe
X>=3D3) it doesn't sleep anymore -- I may be lucky sometimes, and it is suc=
cessful
also in 2.6.17-mm5, but most time everything I get is Freezing and nothing =
is
frozen but fishes in my fridge.

regards,
-- =

Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
