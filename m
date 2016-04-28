From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: I2C driver for LTC1760 dual smart battery system manager
Date: Thu, 28 Apr 2016 21:15:51 +0200
Message-ID: <1461870951.6670.33.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:40234 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcD1Tga (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 15:36:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org

Hello,

I have written an Kernel driver for the LTC1760 which is basically an
charger which can handle 2 batteries. Datasheet can be found at
http://www.linear.com/product/LTC1760

However, the device has one speciality: Hence it handles two smart
batteries, which are expected to sit on I2C address 0x0b, it implements
an i2c mux. As the device does so, my driver does also (using
i2c_add_mux_adapter() call).
Further more, Linux already ships with an driver capable to talk to
these smart battery chips, namely "sbs-battery".

I currently using device tree to bind the LTC1760 to the smbus it sits
on and further to define the i2c-lines it implements as well as the
batteries sitting on the two muxed lines.

Would you say this approach is technically right? The LTC expects SBS
compliant batteries connected to it, which implies a standard minimal
interface. But binding the batteries via device tree gives the user the
freedom to specify a more specialized driver.
On the other hand one could argue that if the LTC is present, also
batteries are (potentially) present and the LTC driver is responsible to
read the related registers and provide proper PM attributes. Personally
I don't like to rewrite or copy code wich works just fine...

Greetings
Karl-Heinz Schneider

