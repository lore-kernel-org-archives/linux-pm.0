From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: power_supply: Making "enum power_supply_type type" dynamic
Date: Thu, 2 Jul 2015 17:56:17 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD578645A4@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30027 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbbGBR4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 13:56:21 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>

Hi Sebastian/Krzysztof,

Currently 'enum power_supply_type type' is part of 'struct power_supply_desc' which is again defined as a 'const *' in 'struct power_supply'

Can we move the 'enum power_supply_type type' to 'struct power_supply' itself?

Rational behind this is, if you take any mobile  or tablet device it comes with one USB charging port but it can support multiple charging cables like
SDP, CDP and DCP etc.. So whenever we connect any of these cables we need to adjust the charger parameters accordingly.

So the point here is, If we are using same physical charging port and the same charger IC for setting up the charging we can have one power supply class registration
from  the charger driver and change the power supply type based on the cable detection at runtime.

The current implementation forces us to create multiple power supply objects for each cable type which is not optimal as all these objects set/get methods
operate on the same set of registers.

Thanks,
Ram

