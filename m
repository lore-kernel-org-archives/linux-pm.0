From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v5 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Date: Thu, 12 Jan 2017 15:34:58 +0530
Message-ID: <20170112100458.GD3006@localhost.localdomain>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-4-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1484039224-5630-4-git-send-email-ego@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, devicetree@vger.kernel.org, Michael Neuling <mikey@neuling.org>, linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 10, 2017 at 02:37:02PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In the current code for powernv_add_idle_states, there is a lot of code
> duplication while initializing an idle state in powernv_states table.
> 
> Add an inline helper function to populate the powernv_states[] table
> for a given idle state. Invoke this for populating the "Nap",
> "Fastsleep" and the stop states in powernv_add_idle_states.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> -- 

Acked-by: Balbir Singh <bsingharora@gmail.com>
