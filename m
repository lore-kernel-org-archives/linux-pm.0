From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 2/3] thermal: broadcom: ns-thermal: default on iProc
 SoCs
Date: Fri, 19 May 2017 11:33:57 -0700
Message-ID: <95dacb24-8c10-8d3b-9764-a3c208031f6d@gmail.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
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
> Tweak the Kconfig description to mention support for NSP and make the
> default on for iProc based platforms.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Zhang, Eduardo, please apply, the Kconfig and DTS changes have been
queued for 4.13 in my ARM-SoC pull request for Broadcom SoCs.

Thanks!
--
Florian
