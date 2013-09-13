From: Leo Yan <leoy@marvell.com>
Subject: [Question] Verification For arm64: suspend/resume implementation
Date: Fri, 13 Sep 2013 10:53:53 +0800
Message-ID: <52327E41.1070904@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

hi Lorenzo,

I have applied your ARM64's suspend/resume related patches and can built 
successfully. i want to verify these patches on foundation model 
firstly, so below are my questions:

"Code has been tested on AEM v8 models and a simple CPU idle driver that 
enables a C-state where CPUs are reset when wfi is hit."

1. Can u help share this simple cpu idle driver?
2. On the foundation model, if the core is placed into reset state, then 
if there have interrupt is routed to the core, the core still cannot be 
waken up anymore; because the reset bit cannot be released by h/w. So 
how can let the core return back from the reset state?

-- 
Thx,
Leo Yan
