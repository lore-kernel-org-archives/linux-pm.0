From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4] thermal: tango: add resume support
Date: Wed, 07 Sep 2016 10:55:05 +0200
Message-ID: <6763387.6QdSyfOt0d@wuerfel>
References: <57CFD031.7020500@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <57CFD031.7020500@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 7, 2016 10:30:41 AM CEST Marc Gonzalez wrote:
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. There is no
> context to save for this particular block.
> 
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
