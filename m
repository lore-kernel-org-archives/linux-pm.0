From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
 fb_info->lock and mm->mmap_sem ...} causes Xfbdev not working
Date: Fri, 17 Apr 2009 18:25:07 +0200
Message-ID: <20090417182507.0bd85ccc.krzysztof.h1__11180.2391861149$1239987271$gmane$org@poczta.fm>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
	<49E05C36.9040204@s5r6.in-berlin.de> <20090411110840.GA7108@linux>
	<20090411150359.GA8265@linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7951653419963367631=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090411150359.GA8265@linux>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Pavel Roskin <proski@gnu.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

--===============7951653419963367631==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id n3HGowjv026086

On Sat, 11 Apr 2009 17:04:00 +0200
Andrea Righi <righi.andrea@gmail.com> wrote:

> It would be great if someone could help me to test this patch (against
> latest Linus' git - no need to revert 66c1ca).
>=20

I can confirm the patch fixes the issue on radeonfb and cirrusfb drivers =
tested so far.

Regards,
Krzysztof

----------------------------------------------------------------------
Dzwonki na komork=EA!
Sprawdz >> http://link.interia.pl/f2127=20


--===============7951653419963367631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--===============7951653419963367631==--
