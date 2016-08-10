From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 6/8] arm64, dts: add Juno r2 cpu capacity-dmips-mhz
 information
Date: Wed, 10 Aug 2016 16:41:09 +0100
Message-ID: <fedd8373-7cc4-5dc3-3b15-7f4e6129f156@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-7-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468932048-31635-7-git-send-email-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, Jon Medhurst <tixy@linaro.org>, peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Kumar Gala <galak@codeaurora.org>, broonie@kernel.org, linux@arm.linux.org.uk, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pm@vger.kernel.org



On 19/07/16 13:40, Juri Lelli wrote:
> Add Juno r2 cpu capacity-dmips-mhz bindings information.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

(reluctantly :), though I agree the bindings are approved to allow this,
  it seems odd to see capacity-dmips-mhz = <485> here and <578> on R0
  for the A53 CPUs)

-- 
Regards,
Sudeep
