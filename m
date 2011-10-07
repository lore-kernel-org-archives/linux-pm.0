From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up
 latency figures
Date: Thu, 6 Oct 2011 22:17:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110062215270.4611__13071.7856264257$1319703451$gmane$org@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1316622258-3892-9-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Jean

On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> Figures are added to the power domains structs for RET and OFF modes.
> 
> Note: the latency figures for MPU, PER, CORE, NEON have been obtained
> from actual measurements.
> The latency figures for the other power domains are preliminary and
> shall be added.
> 
> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
> for a detailed explanation on where are the numbers magically coming from.
> 
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.

Do the CSWR measurements include the time for the PMIC to scale the 
voltage, or do they just represent the time to enter and exit clock stop 
(presumably with DPLL idling)? 


- Paul
