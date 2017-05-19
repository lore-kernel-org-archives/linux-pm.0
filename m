From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: BCM: Enable thermal support for NSP SoCs
Date: Fri, 19 May 2017 11:29:52 -0700
Message-ID: <f653eff0-3e5b-5e14-6c27-53184ce48ea4@gmail.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-2-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1493410291-16679-2-git-send-email-jon.mason@broadcom.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Mason <jon.mason@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/28/2017 01:11 PM, Jon Mason wrote:
> Change the Northstar Plus Kconfig to select THERMAL and THERMAL_OF,
> which allows the ns-thermal driver to be selected via menuconfig.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Applied, thanks Jon
-- 
Florian
