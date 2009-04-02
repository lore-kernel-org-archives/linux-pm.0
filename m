From: "Premi, Sanjeev" <premi@ti.com>
Subject: Adding PM QoS parameters
Date: Fri, 3 Apr 2009 01:55:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I have just started looking at the PM QoS implementation; I came across this
text in "pm_qos_interface.txt"

[quote]
The infrastructure exposes multiple misc device nodes one per implemented
parameter.  The set of parameters implement is defined by pm_qos_power_init()
and pm_qos_params.h.  This is done because having the available parameters
being runtime configurable or changeable from a driver was seen as too easy to
abuse.
[/quote]

Though I have understood the intent; i feel it may also be limiting the use
where there is a genuine need - specific to an arch/ platform.

Can we allow number of these params to grow upto a reasonable limit (say 8)?
If an arch/platform does not specifies more params, everything remains same.
But we get an opportunity to add arch/platform specific requirements.

Not sure if this has already been discussed earlier, but would like to hear
more thoughts.

Best regards,
Sanjeev
