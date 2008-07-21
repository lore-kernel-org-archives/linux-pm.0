From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches
	for omap
Date: Mon, 21 Jul 2008 23:29:08 +0100
Message-ID: <20080721222908.GF18909__27896.6135731482$1216679675$gmane$org@flint.arm.linux.org.uk>
References: <1216221555-18958-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1216221555-18958-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 16, 2008 at 06:19:05PM +0300, Tony Lindgren wrote:
> I'm reposting the series to a wider audience as Russell King suspected that
> other archs may be interested in reviewing these too, or at least some
> parts of the code.

It would be nice to have some comment on these patches from other
people.  My suspicions is that this infrastructure is solving a
problem found on other SoCs in addition to OMAP, and, if this is
useful to other people, it should become cross-SoC infrastructure.

Since I don't know the answer to whether it would be useful, I'm
trying to ensure that these patches have sufficient exposure to
people who _may_ know the answer.
