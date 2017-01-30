From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 5/5] Documentation:powerpc: Add device-tree bindings
 for power-mgt
Date: Mon, 30 Jan 2017 11:49:53 -0600
Message-ID: <20170130174953.j3mcr2qlmh3fbznb@rob-hp-laptop>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-6-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485333389-5752-6-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 25, 2017 at 02:06:29PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Document the device-tree bindings defining the the properties under
> the @power-mgt node in the device tree that describe the idle states
> for Linux running on baremetal POWER servers.
> 
> These bindings are documented separately instead of using the the
> common idle state bindings since the idle-states on POWER servers
> are exposed as property arrays where as the common idle state bindings
> expect idle-states to be described as nodes.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  .../devicetree/bindings/powerpc/opal/power-mgt.txt | 118 +++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt

Acked-by: Rob Herring <robh@kernel.org>
