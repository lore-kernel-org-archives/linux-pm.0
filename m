From: Paul Mackerras <paulus@samba.org>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Sun, 25 Jun 2006 11:20:39 +1000
Message-ID: <17565.58599.858812.278800@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Guennadi Liakhovetski writes:

> Sorry if this is not the right list to ask. I was surprised to not find =

> any ppc platforms except powermac implementing suspend to RAM? Same for =

> CPU_FREQ - only powermac. What could be the reason?

Presumably no-one else has felt motivated to get them going on other
PPC platforms so far...  Both of these things tend to use very
platform-specific facilities.

Patches welcome.

Paul.
