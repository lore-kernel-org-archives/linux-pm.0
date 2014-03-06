From: Stephen Warren <swarren@wwwdotorg.org>
Subject: thermal-zones DT node bound by name rather than compatible property
Date: Thu, 06 Mar 2014 10:57:01 -0700
Message-ID: <5318B6ED.3060104@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60792 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbaCFR5G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Mar 2014 12:57:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Commit 4e5e4705bf69 "thermal: introduce device tree parser" introduced
the text below into Documentation/devicetree/bindings/thermal/thermal.txt:

> * The thermal-zones node
> 
> The "thermal-zones" node is a container for all thermal zone nodes. It shall
> contain only sub-nodes describing thermal zones as in the section
> "Thermal zone nodes". The "thermal-zones" node appears under "/".

This implies that software must find the thermal-zones node by node
name. Node names aren't supposed to be significant in DT. Rather,
software is supposed to bind to a node by searching for all nodes with a
particular value in the compatible property. While there are some legacy
counter-examples such as /aliases, /chosen, and /cpus, I don't think we
should propagate any more of these in new bindings.

Can this mistake in the binding definition be rectified, or is it too late?
