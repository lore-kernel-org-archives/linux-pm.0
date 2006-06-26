From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Mon, 26 Jun 2006 20:44:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0606262040230.5678@poirot.grange>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
	<17565.58599.858812.278800@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606252034260.9893@poirot.grange>
	<17567.32285.641865.387583@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17567.32285.641865.387583@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>, Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Jun 2006, Johannes Berg wrote:

> powerbooks and ibooks can suspend but all the code for that goes through
> the via-pmu ioctl, not the generic stuff.

On Mon, 26 Jun 2006, Paul Mackerras wrote:

> The STR implementation for powerbooks predates the generic STR support
> (by quite a long way, it was originally done in 1998).  These days it
> uses some parts of the generic STR support but the top-level control
> is still using the old code, because the generic STR code doesn't
> provide all the hooks we need yet.
> =

> For historical reasons, the top-level powerbook STR code is in
> drivers/macintosh/via-pmu.c, and is invoked via an ioctl on /dev/pmu.

Thanks Johannes and Paul! would never find myself... Looking further. =

Expect more questions:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
