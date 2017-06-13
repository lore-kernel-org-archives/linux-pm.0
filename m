From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] dt-bindings: Drop k2g genpd device ID macros
Date: Tue, 13 Jun 2017 15:16:01 -0500
Message-ID: <ca91000a-627b-a655-4304-b64b78bbcf9a@ti.com>
References: <20170522183737.24946-1-d-gerlach@ti.com>
 <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@kernel.org>, Franklin Cooper <fcooper@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Santosh,
On 05/31/2017 11:28 AM, Rob Herring wrote:
> On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
>> Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
>> number of K2G_DEV_x macros to represent each device ID available on the
>> K2G platform for use by the genpd, clock, and reset drivers. Rather than
>> use these macros, which are only used in the device tree for property
>> values and not actually used by the drivers, let's just use the device
>> ID number directly in the device tree to avoid macro bloat.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> Based on discussion here [1] it was agreed that these macros are not needed
>> and it is better to just use the device IDs directly in dt.
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
>>
>>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>>  include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
>>  2 files changed, 3 insertions(+), 92 deletions(-)
>>  delete mode 100644 include/dt-bindings/genpd/k2g.h
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Gentle ping on this. If you're OK with the patch any chance you can pick it up?

Regards,
Dave
