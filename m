From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 0/9] Fix issues and factorize arm/arm64 capacity
 information code
Date: Mon, 10 Apr 2017 16:05:03 +0100
Message-ID: <20170410150503.GS17774@n2100.armlinux.org.uk>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, gregkh@linuxfoundation.org, sudeep.holla@arm.com, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 27, 2017 at 02:18:16PM +0100, Juri Lelli wrote:
> arm and arm64 topology.c share a lot of code related to parsing of capacity
> information. This is v3 of a solution [1] (based on Will's, Catalin's and
> Mark's off-line suggestions) to move such common code in a single place:
> drivers/base/arch_topology.c (by creating such file and conditionally compiling
> it for arm and arm64 only).

I think overall this is okay, with the exception of one patch which seems
to be wrongly worded.  Once that's resolved, then:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

for the series.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
