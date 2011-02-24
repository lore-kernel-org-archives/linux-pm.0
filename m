From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: modelling power supply / charging logic of ebook reader
Date: Thu, 24 Feb 2011 21:13:42 +0100
Message-ID: <201102242113.42463.heiko@sntech.de>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

Warning newbie questions and I'm hoping I'm on the right list :-)

I'm trying to implement charging logic for a device. As these are my first 
steps into the kernel I'd like to solicit opinions in which way to proceed.


Hardware: Qisda ebook-reader family - essentially every machine with an epaper 
display from Sipix build around a s3c2416. Charger IC is a Texas Instruments 
bq24075 connected via gpios. The manufacturers used a fork of 2.6.21.5 and we 
try to make a current kernel usable on the devices.

Somewhere on lkml I read that reimplementing basic charger logic in yet 
another driver is not desired, so I'm looking at using the pda-power driver in 
combination with a simple bq2407x regulator driver based on Philipp Zabels 
driver for the bq24022.

The usb gadget driver has not OTG functionality and vbus detection is done via 
a special gpio. So it seems the gpio-vbus driver seems to be the driver to use 
for this.


Questions:

It's possible to connect the devices usb port to either a normal usb host or a 
dedicated charger with higher current. The current charger type is read from 
some usb registers. So my question would be on how to model this with pda-
power.
The ac-part is propably not usable for this as it seems to require a different 
gpio-source. 
Is implementing some sort of "is_usb_aca"-hook a possible way

The charger also reports its charging status via a gpio. What's the best way 
to implement this with pda-power?
My current idea is to add an is_charging or supply_status hook to pda-power 
and if defined output this value via the get_property method and 
POWER_SUPPLY_STATUS_*. Correct?


Or as a complete alternative is it more reasonable to implement a new power-
supply for this and not add more switches to pda-power?
For example the pcf56033-charger driver has exactly this functionality but for 
a specific device.
As nowadays most of the devices only have an usb port but different charging 
sources for it, is it reasonable to build some sort of generic "gadget-power" 
driver analogous to pda-power or does something of this sort exist?


Thanks for any input :-)
Heiko
