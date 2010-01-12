From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Tue, 12 Jan 2010 23:48:58 +0100
Message-ID: <201001122348.58306.rjw__9000.12305141917$1263336583$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl> <878wc3j6mm.fsf@pollan.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <878wc3j6mm.fsf@pollan.anholt.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eric Anholt <eric@anholt.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 January 2010, Eric Anholt wrote:
> On Sat, 9 Jan 2010 00:45:33 +0100, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Commit cbda12d77ea590082edb6d30bd342a67ebc459e0 (drm/i915: implement
> > new pm ops for i915), among other things, removed the .suspend and
> > .resume pointers from the struct drm_driver object in i915_drv.c,
> > which broke resume without KMS on my MSI Wind U100.
> > 
> > Fix this by reverting that part of commit cbda12d77ea59.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Applied, with a little comment for the next poor person having to figure
> out the difference between these two suspend/resume paths.

Linus has applied this one already.

Rafael
