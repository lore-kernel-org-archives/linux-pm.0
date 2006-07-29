From: Jiri Slaby <jirislaby@gmail.com>
Subject: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sat, 29 Jul 2006 19:57:42 +0159
Message-ID: <44CBA1AD.4060602@gmail.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-pm@vger.kernel.org

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/=
2.6.18-rc2-mm1/

Hello,

I have problems with swsusp again. While suspending, the very last thing ke=
rnel
writes is 'restoring higmem' and then hangs, hardly. No sysrq response at a=
ll.
Here is a snapshot of the screen:
http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif

It's SMP system (HT), higmem enabled (1 gig of ram).

regards,
-- =

<a href=3D"http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
