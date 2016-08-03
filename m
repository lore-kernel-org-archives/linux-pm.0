From: Michael Walle <michael@walle.cc>
Subject: of-thermal and hwmon sensors
Date: Wed, 03 Aug 2016 16:37:50 +0200
Message-ID: <0d0a0779f82247923fed4fb1ea3e7769@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([213.133.101.245]:34047 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbcHCPDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2016 11:03:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>

Hi,

as far as I understand it, there isn't a possibility to expose the 
thermal temperature sensors to the hwmon subsystem if the thermal zones 
are configured via device tree. Because the of-thermal driver hardcodes 
the following:

   /* No hwmon because there might be hwmon drivers registering */
   tzp->no_hwmon = true;

I guess this has to be set to true, because if not no (future) hwmon 
driver will work at all. But as far as I see, the most OF enabled 
thermal drivers don't have corresponding hwmon drivers and therefore 
can't be exposed as hwmon devices.

There was already a small discussion back in 2015:
    https://lkml.org/lkml/2015/4/20/665

but it didn't end in a solution.

Are there any new ideas from your side how to solve this? I'm not really 
into device trees and if I understand it correctly, Robs argument was 
that it should not be upon the device tree to decide which driver should 
be used (if there are multiple ones for one device). Could it be a new 
device node in the device tree with a compatible property like the 
following:
   compatible = "preferred-device", "generic-thermal-hwmon";

-michael
