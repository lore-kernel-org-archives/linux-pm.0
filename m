From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Sun, 25 Jun 2006 20:36:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0606252034260.9893@poirot.grange>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
	<17565.58599.858812.278800@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17565.58599.858812.278800@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun, 25 Jun 2006, Paul Mackerras wrote:

> Guennadi Liakhovetski writes:
> =

> > Sorry if this is not the right list to ask. I was surprised to not find =

> > any ppc platforms except powermac implementing suspend to RAM? Same for =

> > CPU_FREQ - only powermac. What could be the reason?
> =

> Presumably no-one else has felt motivated to get them going on other
> PPC platforms so far...  Both of these things tend to use very
> platform-specific facilities.

Oh, no... Looking in arch/powerpc/platforms/powermac/setup.c at their
struct pm_ops couldn't see any actual code to handle suspends, and then
noticed this:

/* TODO: Merge the suspend-to-ram with the common code !!!
 * currently, this is a stub implementation for suspend-to-disk
 * only
 */

So, there's not a single STR implementation for ppc in the kernel?...

Thanks
Guennadi
---
Guennadi Liakhovetski
