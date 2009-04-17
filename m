From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
	fb_info->lock and	mm->mmap_sem ...} causes Xfbdev not working
Date: Sat, 18 Apr 2009 00:51:11 +0200
Message-ID: <20090417225110.GA6972__28673.4518981122$1240009008$gmane$org@linux>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
	<49E05C36.9040204@s5r6.in-berlin.de>
	<20090411110840.GA7108@linux> <20090411150359.GA8265@linux>
	<20090417182507.0bd85ccc.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090417182507.0bd85ccc.krzysztof.h1@poczta.fm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Pavel Roskin <proski@gnu.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 17, 2009 at 06:25:07PM +0200, Krzysztof Helt wrote:
> On Sat, 11 Apr 2009 17:04:00 +0200
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > It would be great if someone could help me to test this patch (against
> > latest Linus' git - no need to revert 66c1ca).
> > 
> 
> I can confirm the patch fixes the issue on radeonfb and cirrusfb drivers tested so far.
> 
> Regards,
> Krzysztof

Thanks for testing!
-Andrea
