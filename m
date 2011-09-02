From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: how to best map device regulators
Date: Fri, 2 Sep 2011 11:42:00 +0200
Message-ID: <201109021142.01057.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm at an impass on how to implement specific regulators found in an existing 
device.

My first candidate is a "GMT G9093", i.e. two fixed voltage regulators in one ic 
controlled via GPIOs. Here intuition suggest to simply use two instances of 
the fixed-driver - no use in duplicating its function. Correct?


Second, more complex chip, is a TI tps650240, i.e. 3 fixed voltage regulators, 
1 regulator switchable between 2 voltages - all controllable via GPIOs -  and 
two regulators whose enabled-state is controlled by one gpio only.

Here I'm torn between (1) building a new driver and (2) using fixed voltage 
drivers and building a switch-driver for the two voltage-regulator (here I'm 
also not sure if this should be crammed into the fixed-driver, as I think it is 
called fixed for a reason). For (2) I'm also not sure, on how to implement 
support for the two regulators controlled by one gpio.

Thanks
Heiko
