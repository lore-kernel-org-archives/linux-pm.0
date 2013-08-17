From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Date: Sun, 18 Aug 2013 08:09:36 +1000
Message-ID: <1376777376.25016.11.camel@pasglop>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2032060.4bgTKOdEX2@flatron>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
> which 
> the updated bindings[1] define #address-cells = <0> and so no reg 
> property.
> 
> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795

Why did you do that in the binding ? That sounds like looking to create
problems ... 

Traditionally, UP setups just used "0" as the "reg" property on other
architectures, why do differently ?

Ben.
