From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: console (ttyX) forgot the font after hibernation
Date: Thu, 1 May 2008 17:42:23 +0200
Message-ID: <200805011742.23548.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pavel@suse.cz
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

under my (stable) Gentoo I use the consolefont lat9w-10 instead of the defa=
ult
(and much larger) font. If I hibernate my ThinkPad T41 and wake it up again,
the console uses the default font instead :-(

This doesn't happen with suspend to ram, only if I hibernate the system:

tfoerste@n22 ~/devel/linux-2.6 $ uname -a
Linux n22 2.6.24-gentoo-r4 #4 Sun Apr 20 12:16:18 CEST 2008 i686 Intel(R) P=
entium(R) M processor 1700MHz GenuineIntel GNU/Linux

I tested this with 2.6.25 and older kernels, always I goi the described beh=
aviour.
-- =

MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
