From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up
 latency figures
Date: Mon, 10 Oct 2011 16:52:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101652290.5205__31091.8990443044$1319679584$gmane$org@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-9-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com>
	<CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
	<alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Oct 2011, Paul Walmsley wrote:

> OK.  sys_offmode only applies to OFF mode.  Voltage scaling can also occur 
> during RETENTION and INACTIVE ("sleep").  So were these results with 
> retention and voltage scaling disabled?

This last sentence should have read:

So were these results with retention and sleep voltage scaling disabled?

- Paul
