From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Wed, 27 May 2009 13:10:42 +0100
Message-ID: <20090527121042.GD1970__11229.9950248145$1243426301$gmane$org@sirena.org.uk>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, paul@pwsan.com, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 27, 2009 at 07:06:25PM +0900, Magnus Damm wrote:

> These patches extend platform device and driver interfaces to
> allow architectures to implement platform device runtime pm.

> Have a look at the last patch for a SuperH mockup that shows how
> it all fits together. We need this or a similar interface to be able
> to enter deep sleep states on SuperH. I believe other architectures
> have similar requirements.

ARM definitely does.  The OMAP SoCs are probably furthest along in
software support for this sort of functionality but it's pretty much
standard for modern ARMs.  I'd CC in the ARM list but it's subscribers
only, though the OMAP folks are also over on linux-omap@vger.kernel.org
which isn't.
