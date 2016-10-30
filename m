From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 REPOST 0/9] CPUs capacity information for
 heterogeneous systems
Date: Sun, 30 Oct 2016 14:22:46 +0000
Message-ID: <20161030142246.od5skjzegyp62hma@localhost>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, morten.rasmussen@arm.com, broonie@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 17, 2016 at 04:46:41PM +0100, Juri Lelli wrote:
> I'm thus now assuming that everybody is OK with the patches and that they can
> be queued for 4.10 (we certainly need this plumbing at this point). Please
> speak if my assumption is wrong (and provide feedback! :).
> Otherwise I'm going to:
> 
>  - use Russell's patching system for patches 2 and 8
>  - ask Sudeep to pull patches 3,5,6 and 7
>  - ask Catalin/Will to pull patches 1,4 and 9

I'm happy to queue patches 1, 4 and 9 for 4.10 (though it might have
been easier for the whole series to go through arm-soc).

> Do you think we might get into trouble splitting the merge process this way?

Probably not. The only minor downside is that I have to grab a new DT
for Juno from Sudeep to test the patches. Not an issue, though.

-- 
Catalin
